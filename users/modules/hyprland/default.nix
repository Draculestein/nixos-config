{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./lockscreen.nix
    ./config.nix
    ./env.nix
    ./autostart.nix
    ./binds.nix
    ./polkit.nix
    ./xdph.nix
    ./hyprpaper.nix
    ./windowrules.nix

    ../flameshot.nix

  ];

  home.packages = with pkgs; [
    brightnessctl
    playerctl
    wl-clipboard
    clipse
    wl-screenrec
    slurp
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;

    systemd.variables = [ "--all" ];
  };
}
