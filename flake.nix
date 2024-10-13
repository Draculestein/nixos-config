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
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };

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
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";

      lib = nixpkgs-unstable.lib;

      # unstable-small-pkgs = import inputs.nixos-unstable-small { inherit system; };
      # xdphOverlay = final: prev: {
      #   inherit (unstable-small-pkgs) xdg-desktop-portal-hyprland;
      # };

      pkgs = import nixpkgs-unstable {
        inherit system;
        # overlays = [ inputs.hyprpanel.overlay ];
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
            inherit pkgs;
          };
          modules = [ ./system/FlowX13 ];
        };
      };

      homeConfigurations = {
        albertjul = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./users/albertjul/home.nix ];
        };
      };
    };
}

