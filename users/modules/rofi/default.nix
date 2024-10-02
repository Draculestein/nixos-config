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
    theme =  "$XDG_CONFIG_HOME/rofi/launchers/type-6/style10.rasi";
  };
}
