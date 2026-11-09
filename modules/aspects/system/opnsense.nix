{ den, lib, ... }:
{
  den.aspects.opnsense = {
    includes = [ den.aspects.incus ];

    settings = {
      wanInterface = lib.mkOption {
        type = lib.types.str;
        description = "Physical NIC bridged to the OPNsense WAN.";
      };
      lanInterface = lib.mkOption {
        type = lib.types.str;
        description = "Physical NIC carrying the tagged OPNsense LAN trunk.";
      };
      lanVlans = lib.mkOption {
        type = lib.types.listOf (lib.types.ints.between 2 4094);
        description = "VLANs tagged on the LAN trunk and passed to OPNsense.";
      };
    };

    # The LAN trunk bridge exists once the OPNsense VM is reconciled.
    bridges =
      { host, ... }:
      {
        name = "opnsense-lan";
        unit = "opnsense-vm.service";
        vlans = host.settings.opnsense.lanVlans;
      };

    nixos =
      { config, host, pkgs, ... }:
      let
        cfg = host.settings.opnsense;
        version = "26.7";
        instanceName = "opnsense";
        installerVolume = "opnsense-${version}-installer";
        inherit (cfg) wanInterface lanInterface;
        trunkVlans = cfg.lanVlans;
        wanConfig = yaml.generate "opnsense-wan.yaml" {
          description = "OPNsense physical WAN";
          config = {
            "bridge.external_interfaces" = wanInterface;
            "ipv4.address" = "none";
            "ipv6.address" = "none";
            "ipv4.nat" = "false";
            "ipv6.nat" = "false";
            "ipv4.firewall" = "false";
            "ipv6.firewall" = "false";
            "dns.mode" = "none";
          };
        };
        yaml = pkgs.formats.yaml { };
        lanConfig = yaml.generate "opnsense-lan.yaml" {
          description = "OPNsense physical LAN trunk";
          config = {
            "bridge.external_interfaces" = lanInterface;
            "ipv4.address" = "none";
            "ipv6.address" = "none";
            "ipv4.nat" = "false";
            "ipv6.nat" = "false";
            "ipv4.firewall" = "false";
            "ipv6.firewall" = "false";
            "dns.mode" = "none";
          };
        };
        profileConfig = yaml.generate "opnsense-profile.yaml" {
          description = "OPNsense virtual machine";
          config = {
            "boot.autostart" = "true";
            "limits.cpu" = "4";
            "limits.memory" = "8GiB";
            "security.csm" = "false";
            "security.secureboot" = "false";
          };
          devices = {
            root = {
              path = "/";
              pool = "default";
              size = "32GiB";
              type = "disk";
            };
            wan = {
              hwaddr = "02:00:00:00:00:01";
              network = "opnsense-wan";
              type = "nic";
            };
            lan = {
              hwaddr = "02:00:00:00:00:02";
              network = "opnsense-lan";
              "vlan.tagged" = lib.concatMapStringsSep "," toString trunkVlans;
              type = "nic";
            };
          };
        };
        compressedInstaller = pkgs.fetchurl {
          url = "https://pkg.opnsense.org/releases/mirror/OPNsense-${version}-dvd-amd64.iso.bz2";
          hash = "sha256-lcr+3abVsizoMuJJ3CMJEQ++4Z+BOteM8ouz04cYa/s=";
        };
        installer = pkgs.runCommand "OPNsense-${version}-dvd-amd64.iso" { nativeBuildInputs = [ pkgs.bzip2 ]; } ''
          bunzip2 --stdout ${compressedInstaller} > "$out"
        '';
      in
      {
        # Incus owns these unnumbered router links, not NetworkManager.
        networking.networkmanager.unmanaged = [
          "interface-name:${wanInterface}"
          "interface-name:${lanInterface}"
        ];
        networking.interfaces.${wanInterface}.useDHCP = false;
        networking.interfaces.${lanInterface}.useDHCP = false;
        boot.kernel.sysctl."net.ipv6.conf.${wanInterface}.disable_ipv6" = 1;
        boot.kernel.sysctl."net.ipv6.conf.${lanInterface}.disable_ipv6" = 1;

        # Bridged guest addresses intentionally have no routes on the host.
        networking.nftables.enable = true;
        networking.firewall.extraReversePathFilterRules = ''
          iifname { "opnsense-wan", "opnsense-lan" } accept
        '';
        networking.nftables.tables.opnsense-host-isolation = {
          family = "inet";
          content = ''
            chain input {
              type filter hook input priority -10; policy accept;
              iifname { "opnsense-wan", "${wanInterface}" } drop
            }
          '';
        };

        systemd.services.opnsense-vm = {
          description = "Reconcile the OPNsense Incus VM";
          wantedBy = [ "multi-user.target" ];
          after = [
            "incus-config.service"
            "NetworkManager.service"
            "sys-subsystem-net-devices-${wanInterface}.device"
            "sys-subsystem-net-devices-${lanInterface}.device"
          ];
          requires = [
            "incus-config.service"
            "sys-subsystem-net-devices-${wanInterface}.device"
            "sys-subsystem-net-devices-${lanInterface}.device"
          ];
          partOf = [ "incus.service" ];
          path = [ config.virtualisation.incus.package pkgs.iproute2 pkgs.jq ];

          script = ''
            if ! incus network show opnsense-wan >/dev/null 2>&1; then
              incus network create opnsense-wan --type=bridge ipv4.address=none ipv6.address=none
            fi
            incus network edit opnsense-wan < ${wanConfig}

            if ! incus network show opnsense-lan >/dev/null 2>&1; then
              incus network create opnsense-lan --type=bridge ipv4.address=none ipv6.address=none
            fi
            incus network edit opnsense-lan < ${lanConfig}
            for vlan in ${lib.concatMapStringsSep " " toString trunkVlans}; do
              bridge vlan add dev ${lanInterface} vid "$vlan"
            done

            if ! incus profile show opnsense >/dev/null 2>&1; then
              incus profile create opnsense
            fi
            incus profile edit opnsense < ${profileConfig}

            if ! incus info ${instanceName} >/dev/null 2>&1; then
              if ! incus storage volume show default ${installerVolume} >/dev/null 2>&1; then
                incus storage volume import default ${installer} ${installerVolume} --type=iso
              fi
              incus init ${instanceName} --empty --vm --profile opnsense
              incus config device add ${instanceName} installer disk \
                pool=default \
                source=${installerVolume} \
                boot.priority=10
            else
              # Preserve operator-controlled media attachments after initial creation.
              incus profile assign ${instanceName} opnsense
            fi
            incus config set ${instanceName} image.os=FreeBSD

            # Router NICs follow the profile, including after a staged migration.
            localDevices="$(incus query /1.0/instances/${instanceName})"
            for device in wan lan; do
              if printf '%s\n' "$localDevices" | jq -e --arg device "$device" '.devices | has($device)' >/dev/null; then
                incus config device remove ${instanceName} "$device"
              fi
            done

            if [ "$(incus list ${instanceName} --format csv -c s)" != "RUNNING" ]; then
              incus start ${instanceName}
            fi
          '';

          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };
        };
      };
  };
}
