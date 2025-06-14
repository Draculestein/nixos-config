{ config, lib, pkgs, inputs, ... }: {

  imports = [
    ../swww # For wallpaper
    ../clipse.nix
    ./lockscreen.nix
    ./binds.nix
    ./settings.nix
    ./window-rules.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    xwayland-satellite-unstable
    waybar
    lm_sensors
    rofi-wayland
  ] ++ [
    inputs.ignis.packages.${system}.ignis
  ];

  services.mako.enable = true;
  services.playerctld.enable = true;
  programs.fuzzel.enable = true;
}
