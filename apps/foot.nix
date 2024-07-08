{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        title = "foot";
        pad = "25x25";
        font = "Hasklug Nerd Font:size=12";
        dpi-aware = false;
        bold-text-in-bright = false;
      };

      cursor = {
        color = "ffcc66 665a44";
      };

      colors = {
        foreground = "cccac2";
        background = "242936";

        regular0 = "242936"; # black
        regular1 = "f28779"; # red
        regular2 = "d5ff80"; # green
        regular3 = "ffd173"; # yellow
        regular4 = "73d0ff"; # blue
        regular5 = "dfbfff"; # magenta
        regular6 = "5ccfe6"; # cyan
        regular7 = "cccac2"; # white

        bright0 = "fcfcfc"; # bright black
        bright1 = "f07171"; # bright red
        bright2 = "86b300"; # bright gree
        bright3 = "f2ae49"; # bright yellow
        bright4 = "399ee6"; # bright blue
        bright5 = "a37acc"; # bright magenta
        bright6 = "55b4d4"; # bright cyan
        bright7 = "5c6166"; # bright white
      };

      key-bindings = {
        scrollback-up-page = "Page_Up";
        scrollback-down-page = "Page_Down";
        search-start = "Control+f";
      };

      search-bindings = {
        cancel = "Escape";
        find-prev = "Shift+F3";
        find-next = "F3 Control+G";
      };

    };
  };
}
