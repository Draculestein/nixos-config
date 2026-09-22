{ den, ... }:
{
  den.aspects.opnsense = {
    includes = [ den.aspects.incus ];

    nixos =
      { config, lib, pkgs, ... }:
      let
        version = "26.7";
        instanceName = "opnsense";
        installerVolume = "opnsense-${version}-installer";
        installFromIso = true;
        yaml = pkgs.formats.yaml { };
        lanConfig = yaml.generate "opnsense-lan.yaml" {
          description = "Isolated OPNsense LAN";
          config = {
            "ipv4.address" = "none";
            "ipv6.address" = "none";
          };
        };
        profileConfig = yaml.generate "opnsense-profile.yaml" {
          description = "OPNsense virtual machine";
          config = {
            "boot.autostart" = "true";
            "image.os" = "FreeBSD";
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
              network = "incusbr0";
              type = "nic";
            };
            lan = {
              hwaddr = "02:00:00:00:00:02";
              network = "opnsense-lan";
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
        systemd.services.opnsense-vm = {
          description = "Reconcile the OPNsense Incus VM";
          wantedBy = [ "multi-user.target" ];
          after = [ "incus-config.service" ];
          requires = [ "incus-config.service" ];
          partOf = [ "incus.service" ];
          path = [ config.virtualisation.incus.package ];

          script = ''
            if ! incus network show opnsense-lan >/dev/null 2>&1; then
              incus network create opnsense-lan --type=bridge
            fi
            incus network edit opnsense-lan < ${lanConfig}

            if ! incus profile show opnsense >/dev/null 2>&1; then
              incus profile create opnsense
            fi
            incus profile edit opnsense < ${profileConfig}

            ${lib.optionalString installFromIso ''
              if ! incus storage volume show default ${installerVolume} >/dev/null 2>&1; then
                incus storage volume import default ${installer} ${installerVolume} --type=iso
              fi
            ''}

            if ! incus info ${instanceName} >/dev/null 2>&1; then
              incus init ${instanceName} --empty --vm --profile opnsense
            else
              incus profile assign ${instanceName} opnsense
            fi

            ${lib.optionalString installFromIso ''
              if ! incus config device get ${instanceName} installer type >/dev/null 2>&1; then
                incus config device add ${instanceName} installer disk \
                  pool=default \
                  source=${installerVolume} \
                  boot.priority=10
              else
                incus config device set ${instanceName} installer \
                  pool=default \
                  source=${installerVolume} \
                  boot.priority=10
              fi
            ''}
            ${lib.optionalString (!installFromIso) ''
              if incus config device get ${instanceName} installer type >/dev/null 2>&1; then
                incus config device remove ${instanceName} installer
              fi
            ''}

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
