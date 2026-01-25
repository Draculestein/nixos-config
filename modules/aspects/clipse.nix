{ den, ... }:
{
  den.aspects.clipse = {
    homeManager = { config, lib, pkgs, ... }: {
      home.packages = [
        pkgs.wl-clipboard
      ];

      services.clipse = {
        enable = true;
        keyBindings = {
          "choose" = "enter";
          "clearSelected" = "S";
          "down" = "down";
          "end" = "end";
          "filter" = "/";
          "home" = "home";
          "more" = "?";
          "nextPage" = "right";
          "prevPage" = "left";
          "preview" = "v";
          "quit" = "q";
          "remove" = "x";
          "selectDown" = "ctrl+down";
          "selectSingle" = "s";
          "selectUp" = "ctrl+up";
          "togglePin" = "p";
          "togglePinned" = "tab";
          "up" = "up";
          "yankFilter" = "ctrl+s";
        };
      };
    };
  };
}
