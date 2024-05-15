{

description = "Main flake";

inputs = {
  nixpkgs.url = "nixpkgs/nixos-23.11";
  nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

  disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  home-manager = {
    url = "github:nix-community/home-manager/release-23.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = {self, nixpkgs, nixpkgs-unstable, ... }@inputs: 
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    home-manager = inputs.home-manager;
  in {
    nixosConfigurations = {
      AlbertFlowX13 = lib.nixosSystem {
        inherit system;
        modules = [ 
          inputs.disko.nixosModules.default
          (import ./disk_config.nix { device = "/dev/vda"; })

          ./configuration.nix
        ];
      };
    };

    homeConfigurations = {
      albertjul = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };


}

