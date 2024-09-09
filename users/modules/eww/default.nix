{config, lib,  pkgs, ...}:
{
  home.packages = with pkgs;[
    eww
  ];

  home.file = {
    ".config/eww" = {
      enable = true;
      source = ../modules/eww;
    };
  };
}