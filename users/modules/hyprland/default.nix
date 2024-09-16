{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./config.nix
    ./env.nix
    ./autostart.nix
    ./binds.nix
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

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;

    systemd.variables = [ "--all" ];
  };
}
