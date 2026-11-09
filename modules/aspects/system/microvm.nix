# MicroVM guests as den hosts, adapted from den's `templates/microvm`.
#
#   den.hosts.x86_64-linux.<guest>.intoAttr = [ ];           # no nixosConfiguration
#   den.hosts.x86_64-linux.<host>.microvm.guests = [ den.hosts.x86_64-linux.<guest> ];
#   den.aspects.<guest>.includes = [ den.aspects.microvm-guest ... ];
#
# A guest is resolved through its own den pipeline and delivered to the host
# at `microvm.vms.<guest>.config`, so any service aspect works unchanged on a
# guest or on a bare-metal/VPS host.
{ den, lib, inputs, ... }:
let
  inherit (den.lib.policy) resolve include provide;

  guestCfg = vm: vm.settings.microvm-guest;
  tapOf = vm: let tap = (guestCfg vm).tap; in if tap != null then tap else "vm-${vm.name}";
  secretsDir = vm: "/var/lib/microvms/${vm.name}/secrets";
in
{
  flake-file.inputs.microvm = {
    url = "github:microvm-nix/microvm.nix";
    inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  # Guest aspects may emit `microvm` keys; they land at `microvm.vms.<guest>`
  # on the host (e.g. `microvm.autostart`).
  den.classes.microvm.description = "MicroVM guest declaration (microvm.vms.<name> options)";

  den.schema.host.imports = [
    {
      options.microvm.guests = lib.mkOption {
        type = lib.types.listOf lib.types.raw;
        default = [ ];
        description = ''
          Guest MicroVMs, as den hosts: `[ den.hosts.x86_64-linux.foo ]`.
          A non-empty list includes `den.aspects.microvm-host`.
        '';
      };
    }
  ];

  den.policies.host-to-microvm-host =
    { host, ... }:
    lib.optionals (host.microvm.guests != [ ]) [
      (resolve.to "microvm-host" { inherit host; })
      (include den.aspects.microvm-host)
    ];

  den.policies.microvm-host-to-microvm-guest =
    { host, ... }: map (vm: resolve.to "microvm-guest" { inherit host vm; }) host.microvm.guests;

  # Resolve the guest as an isolated host pipeline and deliver only its
  # modules to the host. The guest keeps its own erofs store image: the host
  # /nix/store is deliberately not shared into guests.
  den.policies.microvm-guest-resolve-vm =
    { host, vm, ... }:
    [
      (provide {
        class = host.class;
        path = [ "microvm" "vms" vm.name "config" ];
        module = _: den.lib.aspects.resolve vm.class (den.lib.resolveEntity "host" { host = vm; });
      })
      (provide {
        class = host.class;
        path = [ "microvm" "vms" vm.name ];
        module = _: den.lib.aspects.resolve "microvm" vm.aspect;
      })
    ];

  den.schema.host.includes = [ den.policies.host-to-microvm-host ];
  den.schema.microvm-host.includes = [ den.policies.microvm-host-to-microvm-guest ];
  den.schema.microvm-guest.includes = [ den.policies.microvm-guest-resolve-vm ];

  # Guest side: hardware, persistent /var and a static address on a bridge.
  den.aspects.microvm-guest = {
    settings = {
      bridge = lib.mkOption {
        type = lib.types.str;
        description = "Host bridge the guest's tap interface joins.";
      };
      vlan = lib.mkOption {
        type = lib.types.nullOr (lib.types.ints.between 2 4094);
        default = null;
        description = ''
          VLAN the tap joins as an untagged access port. Requires VLAN
          filtering on the bridge. `null` attaches the tap untagged.
        '';
      };
      address = lib.mkOption {
        type = lib.types.str;
        description = "Static IPv4 address.";
      };
      prefixLength = lib.mkOption {
        type = lib.types.ints.between 0 32;
        default = 24;
      };
      gateway = lib.mkOption { type = lib.types.str; };
      nameservers = lib.mkOption { type = lib.types.listOf lib.types.str; };
      mac = lib.mkOption {
        type = lib.types.strMatching "02(:[0-9a-f]{2}){5}";
        description = "Locally administered MAC address.";
      };
      tap = lib.mkOption {
        type = lib.types.nullOr (lib.types.strMatching ".{1,15}");
        default = null;
        description = "Host tap interface name; defaults to `vm-<guest>`.";
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
      generatedSecrets = lib.mkOption {
        type = lib.types.listOf (lib.types.strMatching "[A-Za-z0-9_.-]+");
        default = [ ];
        description = ''
          Random secrets generated once on the host under
          `/var/lib/microvms/<guest>/secrets/` and passed in as systemd
          credentials, readable in the guest at `/run/credentials/@system/<name>`.
        '';
      };
    };

    nixos =
      { host, ... }:
      let
        cfg = guestCfg host;
      in
      {
        microvm = {
          hypervisor = "qemu";
          inherit (cfg) vcpu mem;
          interfaces = [
            {
              type = "tap";
              id = tapOf host;
              inherit (cfg) mac;
            }
          ];
          volumes = [
            {
              image = "var.img";
              label = "var";
              mountPoint = "/var";
              size = cfg.varSize;
            }
          ];
          credentialFiles = lib.genAttrs cfg.generatedSecrets (name: "${secretsDir host}/${name}");
        };
        # Mount persistent state before stage 2 so journald and services never
        # start against the ephemeral tmpfs root.
        fileSystems."/var".neededForBoot = true;
        # System credentials arrive over fw_cfg.
        boot.kernelModules = [ "qemu_fw_cfg" ];

        networking = {
          useNetworkd = true;
          useDHCP = false;
          nftables.enable = true;
          # Also feeds /etc/resolv.conf when a guest disables systemd-resolved.
          inherit (cfg) nameservers;
        };
        systemd.network.networks."10-lan" = {
          matchConfig.MACAddress = cfg.mac;
          address = [ "${cfg.address}/${toString cfg.prefixLength}" ];
          gateway = [ cfg.gateway ];
          dns = cfg.nameservers;
        };
      };
  };

  # Host side, included by `host-to-microvm-host`. Guests attach only to
  # bridges published on the `bridges` quirk.
  den.aspects.microvm-host.nixos =
    { host, bridges, pkgs, utils, ... }:
    let
      guests = host.microvm.guests;
      distinct = f: lib.allUnique (map f guests);
      bridgeOf = vm: lib.findFirst (b: b.name == (guestCfg vm).bridge) null bridges;
    in
    {
      imports = [ inputs.microvm.nixosModules.host ];

      assertions = [
        {
          assertion = distinct (vm: (guestCfg vm).address);
          message = "microvm guests of ${host.name} need distinct addresses.";
        }
        {
          assertion = distinct (vm: (guestCfg vm).mac);
          message = "microvm guests of ${host.name} need distinct MAC addresses.";
        }
        {
          assertion = distinct tapOf;
          message = "microvm guests of ${host.name} need distinct tap names.";
        }
        {
          assertion = lib.allUnique (map (b: b.name) bridges);
          message = "Bridges published twice on ${host.name}: ${toString (map (b: b.name) bridges)}.";
        }
      ]
      ++ lib.concatMap (
        vm:
        let
          cfg = guestCfg vm;
          bridge = bridgeOf vm;
        in
        [
          {
            assertion = bridge != null;
            message = "microvm guest ${vm.name} attaches to bridge ${cfg.bridge}, which no aspect on ${host.name} publishes.";
          }
          {
            assertion = bridge == null || cfg.vlan == null || lib.elem cfg.vlan (bridge.vlans or [ ]);
            message = "microvm guest ${vm.name} uses VLAN ${toString cfg.vlan}, which bridge ${cfg.bridge} does not carry.";
          }
        ]
      ) guests;

      # Taps are bridge ports; the host has no address on guest networks.
      networking.networkmanager.unmanaged = map (vm: "interface-name:${tapOf vm}") guests;

      systemd.services = lib.mergeAttrsList (
        map (
          vm:
          let
            cfg = guestCfg vm;
            tap = tapOf vm;
            bridgeDevice = "sys-subsystem-net-devices-${utils.escapeSystemdPath cfg.bridge}.device";
            # Unit that creates/configures the bridge, e.g. its VLAN filtering.
            bridgeUnit = lib.optional ((bridgeOf vm).unit or null != null) (bridgeOf vm).unit;
          in
          {
            "microvm-bridge-${vm.name}" = {
              description = "Attach MicroVM '${vm.name}' to ${cfg.bridge}";
              after = [
                "microvm-tap-interfaces@${vm.name}.service"
                bridgeDevice
              ]
              ++ bridgeUnit;
              requires = [ "microvm-tap-interfaces@${vm.name}.service" ] ++ bridgeUnit;
              bindsTo = [ bridgeDevice ];
              before = [ "microvm@${vm.name}.service" ];
              requiredBy = [ "microvm@${vm.name}.service" ];
              partOf = [ "microvm@${vm.name}.service" ] ++ bridgeUnit;
              path = [ pkgs.iproute2 ];
              script =
                lib.optionalString (cfg.vlan != null) ''
                  if [ "$(cat /sys/class/net/${cfg.bridge}/bridge/vlan_filtering)" != 1 ]; then
                    echo "${cfg.bridge} has VLAN filtering disabled; refusing to attach ${tap}" >&2
                    exit 1
                  fi
                ''
                + ''
                  ip link set dev ${tap} master ${cfg.bridge}
                ''
                + lib.optionalString (cfg.vlan != null) ''
                  # Access port: untagged VLAN ${toString cfg.vlan} only, never the bridge default VLAN.
                  bridge vlan del dev ${tap} vid 1 || true
                  bridge vlan add dev ${tap} vid ${toString cfg.vlan} pvid untagged
                '';
              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
              };
            };
          }
          // lib.optionalAttrs (cfg.generatedSecrets != [ ]) {
            # qemu reads credential files as the `microvm` user at VM start.
            "microvm-secrets-${vm.name}" = {
              description = "Generate secrets for MicroVM '${vm.name}'";
              before = [ "microvm@${vm.name}.service" ];
              requiredBy = [ "microvm@${vm.name}.service" ];
              path = [
                pkgs.coreutils
                pkgs.openssl
              ];
              script = ''
                install -d -m 0700 -o microvm ${secretsDir vm}
                umask 0077
                for name in ${lib.escapeShellArgs cfg.generatedSecrets}; do
                  file=${secretsDir vm}/$name
                  if [ ! -s "$file" ]; then
                    openssl rand -base64 24 > "$file"
                  fi
                  chown microvm "$file"
                  chmod 0400 "$file"
                done
              '';
              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
              };
            };
          }
        ) guests
      );
    };
}
