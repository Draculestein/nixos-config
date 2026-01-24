{ config, lib, pkgs, inputs, ... }: {

  imports = [
    ../gammastep.nix
    ./lockscreen.nix
    ./binds.nix
    ./settings.nix
    ./window-rules.nix
  ];

  home.packages = [
    pkgs.brightnessctl
    pkgs.xwayland-satellite-unstable
    pkgs.waybar
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

}
