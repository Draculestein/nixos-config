{ config, lib, pkgs, ... }:
{
  programs.rofi = {
    enable = true;

    package = pkgs.rofi-wayland.override {
      plugins = [
        pkgs.rofi-emoji-wayland
        pkgs.rofi-rbw-wayland
      ];
    };

    terminal = "${pkgs.foot}/bin/foot";
    theme =  ./launcher.rasi;
  };
}
