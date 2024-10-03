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

    ../eww
    ../flameshot.nix
    ../swaync.nix
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

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;

    systemd.variables = [ "--all" ];

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      inputs.hyprgrass.packages.${pkgs.system}.default
    ];
  };
}
