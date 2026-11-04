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
      incus.storagePool = {
        driver = "zfs";
        config.source = "zroot/incus";
      };
      users.albertjul = {
        aspect = den.aspects.heimdall-admin;
        classes = [ "user" ];
      };
    };
  };
}
