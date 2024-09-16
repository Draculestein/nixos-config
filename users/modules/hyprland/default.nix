{ config, pkgs, lib, ... }:
{
  imports = [
    ./config.nix
    ./polkit.nix
    ./xdph.nix
    ./hyprpaper.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    playerctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
