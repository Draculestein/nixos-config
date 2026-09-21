{ den, ... }:
{
  den.aspects.incus.nixos = {
    virtualisation.incus = {
      enable = true;
      ui.enable = true;
      preseed = {
        config."core.https_address" = ":8443";
        networks = [
          {
            name = "incusbr0";
            type = "bridge";
            config = {
              "ipv4.address" = "10.0.100.1/24";
              "ipv4.nat" = "true";
            };
          }
        ];
        profiles = [
          {
            name = "default";
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
          }
        ];
        storage_pools = [
          {
            name = "default";
            driver = "dir";
            config.source = "/var/lib/incus/storage-pools/default";
          }
        ];
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
