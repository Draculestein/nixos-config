{ config, lib, pkgs, ... }: {
  programs.niri.settings = {
    debug = {
      render-drm-device = "/dev/dri/renderD129";
    };

    environment = {
      GDK_BACKEND = "wayland,x11,*";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";

      # Qt variables
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };

    spawn-at-startup = [
      {
        command = [ "swww-randomize" "~/Pictures/Wallpapers" "1800" ];
      }
      {
        command = [ "hypridle" ];
      }
    ];

    input = {
      keyboard = {
        xkb.layout = "us";
      };

      touchpad = {
        enable = true;
        tap = true;
        dwt = true;
        natural-scroll = true;
      };

      mouse = {
        enable = true;
      };

      trackpoint = {
        enable = true;
      };

      touch = {
        map-to-output = "eDP-1";
      };

      tablet = {
        enable = true;
        map-to-output = "eDP-1";
      };

      # focus-follows-mouse.enable = true;
    };

    outputs = {
      "eDP-1" = {
        enable = true;
        scale = 2.0;
        mode = {
          width = 3840;
          height = 2400;
          refresh = 60.00;
        };

        position = {
          x = 1920;
          y = 0;
        };
      };

      "ASUSTek COMPUTER INC VG278 M3LMQS154329" = {
        enable = true;
        variable-refresh-rate = "on-demand";
        scale = 1.0;
        mode = {
          width = 1920;
          height = 1080;
          refresh = 164.917;
        };

        position = {
          x = 0;
          y = 0;
        };
      };
    };

    layout = {
      gaps = 10;

      focus-ring = {
        enable = true;
        width = 2;
      };

      border = {
        enable = true;
        width = 2;
      };

      struts = {
        left = 24;
        right = 24;
        top = 2;
        bottom = 2;
      };

      tab-indicator = {
        place-within-column = true;
      };
    };

    animations = {
      enable = true;
      slowdown = 0.9;
    };

    clipboard.disable-primary = true;
    cursor.hide-when-typing = true;
    hotkey-overlay.skip-at-startup = true;
  };
}
