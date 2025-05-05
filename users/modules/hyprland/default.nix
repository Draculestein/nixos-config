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

    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "-all" ];
    };
  };

}
