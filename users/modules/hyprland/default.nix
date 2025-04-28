{ config, pkgs, lib, inputs, ... }:
{

  # home.packages = with pkgs; [
  #   brightnessctl
  #   playerctl
  #   blueman
  #   wl-clipboard
  #   clipse
  #   kooha
  # ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    xwayland.enable = true;
  };
}
