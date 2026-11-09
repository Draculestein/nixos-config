{ den, inputs, lib, ... }:
let
  # The OPNsense LAN trunk bridge (see opnsense.nix).
  bridge = "opnsense-lan";

  guestOptions =
    { name, ... }:
    {
      options = {
        vlan = lib.mkOption {
          type = lib.types.ints.between 2 4094;
          description = "OPNsense VLAN the guest joins as an untagged access port.";
        };
        address = lib.mkOption {
          type = lib.types.str;
          description = "Static IPv4 address on the VLAN.";
        };
        prefixLength = lib.mkOption {
          type = lib.types.ints.between 0 32;
          default = 24;
        };
        gateway = lib.mkOption {
          type = lib.types.str;
          description = "OPNsense address on the VLAN.";
        };
        nameservers = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          description = "Resolvers used by the guest.";
        };
        mac = lib.mkOption {
          type = lib.types.strMatching "02(:[0-9a-f]{2}){5}";
          description = "Locally administered MAC address.";
        };
        tap = lib.mkOption {
          type = lib.types.strMatching ".{1,15}";
          default = "vm-${name}";
          description = "Host tap interface name (at most 15 characters).";
        };
        vcpu = lib.mkOption {
          type = lib.types.ints.positive;
          default = 1;
        };
        mem = lib.mkOption {
          type = lib.types.ints.positive;
          default = 512;
          description = "Memory in MiB.";
        };
        varSize = lib.mkOption {
          type = lib.types.ints.positive;
          description = "Size in MiB of the persistent /var volume.";
        };
        credentialFiles = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = { };
          description = ''
            Host files passed to the guest as systemd system credentials,
            keyed by credential name. They are read by the `microvm` user.
          '';
        };
      };
    };

  guestModule =
    name: guest:
    { ... }:
    {
      system.stateVersion = "26.05";

      microvm = {
        hypervisor = "qemu";
        inherit (guest) vcpu mem credentialFiles;
        interfaces = [
          {
            type = "tap";
            id = guest.tap;
            inherit (guest) mac;
          }
        ];
        volumes = [
          {
            image = "var.img";
            label = "var";
            mountPoint = "/var";
            size = guest.varSize;
          }
        ];
      };
      # Mount persistent state before stage 2 so journald and services never
      # start against the ephemeral tmpfs root.
      fileSystems."/var".neededForBoot = true;
      # System credentials arrive over fw_cfg.
      boot.kernelModules = [ "qemu_fw_cfg" ];

      networking = {
        hostName = name;
        useNetworkd = true;
        useDHCP = false;
        nftables.enable = true;
        # Also feeds /etc/resolv.conf when a guest disables systemd-resolved.
        nameservers = guest.nameservers;
      };
      systemd.network.networks."10-lan" = {
        matchConfig.MACAddress = guest.mac;
        address = [ "${guest.address}/${toString guest.prefixLength}" ];
        gateway = [ guest.gateway ];
        dns = guest.nameservers;
      };
    };
in
{
  flake-file.inputs.microvm = {
    url = "github:microvm-nix/microvm.nix";
    inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  # Declarative guests are built with the host's package set and deployed
  # together with the host closure. Each guest is an access port on one
  # OPNsense VLAN; OPNsense routes it and owns the inter-VLAN policy.
  den.aspects.microvm-host = {
    includes = [ den.aspects.opnsense ];

    nixos =
      { config, pkgs, ... }:
      let
        guests = config.lanMicrovms;
      in
      {
        imports = [ inputs.microvm.nixosModules.host ];

        options.lanMicrovms = lib.mkOption {
          description = ''
            MicroVMs attached to the OPNsense LAN trunk. Service modules add
            their payload through `microvm.vms.<name>.config`.
          '';
          default = { };
          type = lib.types.attrsOf (lib.types.submodule guestOptions);
        };

        config = {
          assertions =
            let
              unique = attr: lib.length (lib.unique (lib.mapAttrsToList (_: g: g.${attr}) guests)) == lib.length (lib.attrNames guests);
            in
            map
              (attr: {
                assertion = unique attr;
                message = "lanMicrovms: every guest needs a distinct ${attr}.";
              })
              [
                "address"
                "mac"
                "tap"
              ];

          microvm.vms = lib.mapAttrs (name: guest: { config = guestModule name guest; }) guests;

          # The taps are bridge ports; the host has no address on guest VLANs.
          networking.networkmanager.unmanaged = lib.mapAttrsToList (_: g: "interface-name:${g.tap}") guests;

          systemd.services = lib.mapAttrs'
            (
              name: guest:
              lib.nameValuePair "microvm-vlan-${name}" {
                description = "Attach MicroVM '${name}' to VLAN ${toString guest.vlan}";
                after = [
                  "microvm-tap-interfaces@${name}.service"
                  "opnsense-vm.service"
                ];
                requires = [
                  "microvm-tap-interfaces@${name}.service"
                  "opnsense-vm.service"
                ];
                before = [ "microvm@${name}.service" ];
                requiredBy = [ "microvm@${name}.service" ];
                partOf = [
                  "microvm@${name}.service"
                  "opnsense-vm.service"
                ];
                path = [ pkgs.iproute2 ];
                script = ''
                  if [ "$(cat /sys/class/net/${bridge}/bridge/vlan_filtering)" != 1 ]; then
                    echo "${bridge} has VLAN filtering disabled; refusing to attach ${guest.tap}" >&2
                    exit 1
                  fi
                  ip link set dev ${guest.tap} master ${bridge}
                  # Access port: untagged VLAN ${toString guest.vlan} only, never the bridge default VLAN.
                  bridge vlan del dev ${guest.tap} vid 1 || true
                  bridge vlan add dev ${guest.tap} vid ${toString guest.vlan} pvid untagged
                '';
                serviceConfig = {
                  Type = "oneshot";
                  RemainAfterExit = true;
                };
              }
            )
            guests;
        };
      };
  };
}
