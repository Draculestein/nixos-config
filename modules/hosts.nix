{ den, inputs, ... }:
{
  # Keep the CLI and activation helper on the same locked deploy-rs revision.
  flake.apps.x86_64-linux.deploy-rs = inputs.deploy-rs.apps.x86_64-linux.default;
  flake.checks.x86_64-linux = inputs.deploy-rs.lib.x86_64-linux.deployChecks inputs.self.deploy;

  den.hosts.x86_64-linux = {
    AlbertProP16 = {
      description = "ASUS H7606";
      users.albertjul = { };
    };
    heimdall = {
      description = "Lenovo Thinkcentre M720Q Tiny";
      instantiate = inputs.nixpkgs-stable.lib.nixosSystem;
      home-manager.module = inputs.home-manager-stable.nixosModules.home-manager;
      settings = {
        incus.storagePool = {
          driver = "zfs";
          config.source = "zroot/incus";
        };
        opnsense = {
          wanInterface = "enp6s0";
          lanInterface = "enp5s0";
          # 10 DMZ, 20 USER, 30 IOT, 40 GUEST, 50 SERVERS.
          lanVlans = [ 10 20 30 40 50 ];
        };
      };
      microvm.guests = [ den.hosts.x86_64-linux.dns ];
      users.albertjul = {
        aspect = den.aspects.heimdall-admin;
        classes = [ "user" ];
      };
    };

    # Technitium DNS, a microVM guest of heimdall on the SERVERS VLAN.
    dns = {
      description = "Technitium DNS microVM";
      intoAttr = [ ]; # built by heimdall, not a nixosConfiguration
      settings = {
        microvm-guest = {
          bridge = "opnsense-lan";
          vlan = 50;
          address = "10.0.50.53";
          gateway = "10.0.50.1";
          nameservers = [ "127.0.0.1" ];
          mac = "02:00:00:00:50:53";
          mem = 1024;
          varSize = 4096;
          secrets.technitium-admin-password = "technitium/admin-password";
        };
        technitium.adminPasswordFile = "/run/credentials/@system/technitium-admin-password";
      };
    };
  };
}
