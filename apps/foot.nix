{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        title = "foot";
        pad = "25x25";
        font = "Hasklug Nerd Font:size=12";
        dpi-aware = false;
        bold-text-in-bright = true;
      };
    };
  };
}
