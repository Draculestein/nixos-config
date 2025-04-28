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

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;

    systemd.variables = [ "--all" ];
  };
}
