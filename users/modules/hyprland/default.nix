{ config, pkgs, lib, inputs, ... }:
{

  imports = [
    ./hyprpaper.nix
    ./binds.nix
    ./config.nix
    ./windowrules.nix
    ./env.nix
    ./lockscreen.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    playerctl
    blueman
    wl-clipboard
    clipse
    kooha
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    xwayland.enable = true;
  };

  wayland.systemd.target = "wayland-wm@hyprland\\x2duwsm.desktop.service";
}
