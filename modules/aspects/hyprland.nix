{ den, ... }: {
  flake-file.inputs = {
    hyprland.url = "github:hyprwm/Hyprland";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  den.aspects.hyprland = {
    nixos = { inputs, pkgs, ... }: {
      programs.hyprland = {
        enable = true;
        # set the flake package
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        # make sure to also set the portal package, so that they are in sync
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };

    homeManager = { config, lib, pkgs, ... }:
      {
        wayland.windowManager.hyprland = {
          enable = true;
          package = null; # Follow the host-level defined package
          portalPackage = null;
          # systemd.variables = [ "--all" ];

        };
      };
  };
}
