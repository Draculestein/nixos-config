{
  description = "Main flake for Draculestein's NixOS setup.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    stylix.url = "github:nix-community/stylix";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq/v2.6.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    config-secrets = {
      url = "git+ssh://git@github.com/Draculestein/nixos-secrets.git?ref=main&shallow=1";
      flake = false;
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    ucodenix.url = "github:e-tho/ucodenix";

  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      flake =
        let
          lib = inputs.nixpkgs-unstable.lib;
          home-manager = inputs.home-manager;
        in
        {
          nixosConfigurations = {
            AlbertProP16 = lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = {
                inherit inputs;
              };

              modules = [
                ./system/ProArtP16
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.albertjul = import ./users/albertjul/home.nix;
                  home-manager.extraSpecialArgs = { inherit inputs; };
                  home-manager.backupFileExtension = "backup";
                }
              ];
            };
          };
        };
    };
}

