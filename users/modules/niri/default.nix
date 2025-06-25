{ config, lib, pkgs, inputs, ... }: {

  imports = [
    ../swww # For wallpaper
    ../clipse.nix
    ../waybar
    ../gammastep.nix
    ../swaync
    ./lockscreen.nix
    ./binds.nix
    ./settings.nix
    ./window-rules.nix
  ];

  home.packages = [
    pkgs.brightnessctl
    pkgs.xwayland-satellite-unstable
    pkgs.waybar
  ];

  # services.mako.enable = true;
  programs.fuzzel.enable = true;
}
