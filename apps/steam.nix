{ config, lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  home.packages = with pkgs; [
    mangohud
  ];

  programs.gamemode.enable = true;
}