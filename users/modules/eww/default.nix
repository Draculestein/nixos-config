{config, lib,  pkgs, ...}:
{
  programs.eww = {
    enable = true;
    enableZshIntegration = true;
    configDir = ../eww;
    package = pkgs.eww;
  };

  # Import scripts for eww
  home.file = {
    
  };
}