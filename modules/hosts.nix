{ inputs, ... }:
{
  den.hosts.x86_64-linux = {
    AlbertProP16 = {
      description = "ASUS H7606";
      users.albertjul = { };
    };
    heimdall = {
      description = "Lenovo Thinkcentre M720Q Tiny";
      instantiate = inputs.nixpkgs-stable.lib.nixosSystem;
      home-manager.module = inputs.home-manager-stable.nixosModules.home-manager;
      users.heimdall = { };
    };
  };
}
