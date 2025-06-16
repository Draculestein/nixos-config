{ config, lib, pkgs, inputs, ... }: {

  imports = [
    ../swww # For wallpaper
    ../clipse.nix
    ../waybar
    ./lockscreen.nix
    ./binds.nix
    ./settings.nix
    ./window-rules.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    xwayland-satellite-unstable
    waybar
    
  ] ++ [
    inputs.ignis.packages.${system}.ignis
  ];

  services.mako.enable = true;
  programs.fuzzel.enable = true;
}
