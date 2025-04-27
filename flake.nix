{
  description = "Main flake for Draculestein's NixOS setup.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixos-unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ags.url = "github:Aylur/ags";
    hyprland.url = "github:hyprwm/Hyprland";

    stylix.url = "github:danth/stylix";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    config-secrets = {
      url = "git+ssh://git@github.com/Draculestein/nixos-secrets.git?ref=main&shallow=1";
      flake = false;
    };

    ghostty.url = "github:ghostty-org/ghostty";
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
          specialArgs = {
            inherit inputs;
            # inherit pkgs;
          };
          modules = [
            ./system/FlowX13
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.albertjul = import ./users/albertjul/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };

        AlbertProP16 = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            # inherit pkgs;
          };

          modules = [
            ./system/ProArtP16
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.albertjul = import ./users/albertjul/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };
    };
}

