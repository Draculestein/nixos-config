{ config, lib, pkgs, ... }: {
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
      "nextPage" = "r;ght";
      "prevPage" = "left";
      "preview" = "t";
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
}
