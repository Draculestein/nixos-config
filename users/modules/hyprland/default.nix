{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./lockscreen.nix
    ./config.nix
    ./env.nix
    ./autostart.nix
    ./binds.nix
    ./polkit.nix
    ./hyprpaper.nix
    ./windowrules.nix

    ../flameshot.nix
    ../swaync
    ../rofi
    ../swayosd.nix
    ../waybar.nix

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

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;

    systemd.variables = [ "--all" ];
  };
}
