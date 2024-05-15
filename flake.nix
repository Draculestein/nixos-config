{

description = "Main flake";

inputs = {
  nixpkgs.url = "nixpkgs/nixos-23.11";
  nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

  disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = {self, nixpkgs, nixpkgs-unstable, ... }@inputs: 
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      AlbertFlowX13 = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          inputs.disko.nixosModules.default
          (import ./disk_config.nix { device = "/dev/vda"; })

          ./configuration.nix
        ];
      };
    };
  };


}

