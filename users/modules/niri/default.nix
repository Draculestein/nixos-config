{ config, lib, pkgs, inputs, ... }: {

  imports = [
    ../swww # For wallpaper
    ./lockscreen.nix
    ./xwayland.nix
    ./binds.nix
    ./settings.nix
    ./window-rules.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    inputs.ignis.packages.${system}.ignis
  ];

  services.mako.enable = true;
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
  programs.fuzzel.enable = true;
}
