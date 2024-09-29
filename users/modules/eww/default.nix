{config, lib,  pkgs, ...}:
{
  programs.eww = {
    enable = true;
    enableZshIntegration = true;
    configDir = ../eww;
    package = pkgs.eww-wayland;
  };
}