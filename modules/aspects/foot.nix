{ den, ... }:
{
  den.aspects.foot = {
    homeManager = { ... }: {
      programs.foot = {
        enable = true;

        settings = {
          main = {
            title = "foot";
            pad = "25x25";
            dpi-aware = "no";
            bold-text-in-bright = false;
          };

          cursor = {
            color = "ffcc66 665a44";
          };

          colors = {
            foreground = "cccac2";
            background = "242936";

            regular0 = "242936";
            regular1 = "f28779";
            regular2 = "d5ff80";
            regular3 = "ffd173";
            regular4 = "73d0ff";
            regular5 = "dfbfff";
            regular6 = "5ccfe6";
            regular7 = "cccac2";

            bright0 = "fcfcfc";
            bright1 = "f07171";
            bright2 = "86b300";
            bright3 = "f2ae49";
            bright4 = "399ee6";
            bright5 = "a37acc";
            bright6 = "55b4d4";
            bright7 = "5c6166";
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
    };
  };
}
