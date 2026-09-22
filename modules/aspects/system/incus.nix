{ den, ... }:
{
  den.aspects.incus.nixos =
    { config, pkgs, ... }:
    let
      yaml = pkgs.formats.yaml { };
      bridgeConfig = yaml.generate "incusbr0.yaml" {
        description = "Default Incus bridge";
        config = {
          "ipv4.address" = "10.0.100.1/24";
          "ipv4.nat" = "true";
        };
      };
      storageConfig = yaml.generate "incus-default-storage.yaml" {
        description = "Default Incus storage pool";
        config.source = "/var/lib/incus/storage-pools/default";
      };
      defaultProfile = yaml.generate "incus-default-profile.yaml" {
        description = "Default Incus profile";
        config = { };
        devices = {
          eth0 = {
            name = "eth0";
            network = "incusbr0";
            type = "nic";
          };
          root = {
            path = "/";
            pool = "default";
            type = "disk";
          };
        };
      };
    in
    {
      virtualisation.incus = {
        enable = true;
        ui.enable = true;
      };

      systemd.services.incus-config = {
        description = "Reconcile the Incus configuration";
        wantedBy = [ "multi-user.target" ];
        after = [ "incus.service" ];
        requires = [ "incus.service" ];
        partOf = [ "incus.service" ];
        path = [ config.virtualisation.incus.package ];

        script = ''
          incus config set core.https_address :8443

          if ! incus storage show default >/dev/null 2>&1; then
            incus storage create default dir source=/var/lib/incus/storage-pools/default
          fi
          incus storage edit default < ${storageConfig}

          if ! incus network show incusbr0 >/dev/null 2>&1; then
            incus network create incusbr0 --type=bridge
          fi
          incus network edit incusbr0 < ${bridgeConfig}

          if ! incus profile show default >/dev/null 2>&1; then
            incus profile create default
          fi
          incus profile edit default < ${defaultProfile}
        '';

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
      };

      networking = {
        nftables.enable = true;
        firewall = {
          allowedTCPPorts = [ 8443 ];
          interfaces.incusbr0 = {
            allowedTCPPorts = [
              53
              67
            ];
            allowedUDPPorts = [
              53
              67
            ];
          };
        };
      };
    };
}
