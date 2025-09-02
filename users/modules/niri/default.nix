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
    inputs.noctalia.packages.${pkgs.system}.default
    inputs.quickshell.packages.${pkgs.system}.default
  ];

}
