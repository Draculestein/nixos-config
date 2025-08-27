{ config, lib, pkgs, inputs, ... }: {

  imports = [
    ../swww # For wallpaper
    ../clipse.nix
    ../waybar
    ../gammastep.nix
    ../swaync
    ../walker.nix
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
