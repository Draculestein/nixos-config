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
  ] ++ [
    inputs.ignis.packages.${system}.ignis
  ];

  services.mako.enable = true;
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
  programs.fuzzel.enable = true;
}
