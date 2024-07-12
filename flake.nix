{

  description = "Main flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";

      lib = nixpkgs-unstable.lib;

      pkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      home-manager = inputs.home-manager;
    in
    {
      nixosConfigurations = {
        AlbertFlowX13 = lib.nixosSystem {
          inherit system;
          modules = [
            inputs.disko.nixosModules.default
            inputs.sops-nix.nixosModules.sops
            (import ./system/FlowX13/disk_config.nix { device = "/dev/nvme0n1"; })

            ./system/FlowX13/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        albertjul = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/albertjul/home.nix ];
        };
      };
    };


}

