{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # ======== Monitor ========
    monitor = [
      "desc:Sharp Corporation LQ134N1JW52, 1920x1200@60, 0x0, 1"
      "desc:ASUSTek COMPUTER INC VG278 M3LMQS154329, 1920x1080@164.92, -1920x0, 1"
    ];

    # ======== Look and Feel ========
    general = {
      gaps_in = 5;
      gaps_out = 10;

      border_size = 2;

      # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
      # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      # "col.inactive_border" = "rgba(595959aa)";

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false;

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;

      layout = "dwindle";
    };

    decoration = {
      rounding = 10;

      # Change transparency of focused and unfocused windows
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      drop_shadow = false;
      shadow_range = 4;
      shadow_render_power = 3;
      # "col.shadow" = "rgba(1a1a1aee)";

      # https://wiki.hyprland.org/Configuring/Variables/#blur
      blur = {
        enabled = false;
      };
    };

    animations = {
      enabled = true;

      # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    dwindle = {
      pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # You probably want this
    };

    master = {
      new_status = "master";
    };

    # ======== Input ========

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
      };
    };

    # https://wiki.hyprland.org/Configuring/Variables/#gestures
    gestures = {
      workspace_swipe = true;
      workspace_swipe_cancel_ratio = 0.15;
    };

    misc = {
      vfr = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };

    "plugin:touch_gestures" = {
      # The default sensitivity is probably too low on tablet screens,
      # I recommend turning it up to 4.0
      sensitivity = 4.0;

      # must be >= 3
      workspace_swipe_fingers = 3;
      long_press_delay = 400;
    };

    # "plugin:hyprbars" = {
    #   # example config
    #   bar_height = 35;
    #   bar_color = "rgb(${config.lib.stylix.colors.base00})";
    #   bar_padding = 10;
    #   bar_button_padding = 8;
    #   bar_precedence_over_border = true;
    #   bar_text_font = "Cantarell";
    #   "col.text" = "rgb(${config.lib.stylix.colors.base05})";

    #   # example buttons (R -> L)
    #   # hyprbars-button = color, size, on-click
    #   hyprbars-button = [
    #     "rgb(${config.lib.stylix.colors.base08}), 14, 󰖭, hyprctl dispatch killactive"
    #   ];
    # };

    # "plugin:hyprexpo" = {
    #   columns = 2;
    #   gap_size = 5;
    #   bg_col = "rgb(111111)";
    #   workspace_method = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1

    #   enable_gesture = true; # laptop touchpad
    #   gesture_fingers = 3; # 3 or 4
    #   gesture_distance = 300; # how far is the "max"
    #   gesture_positive = true; # positive = swipe down. Negative = swipe up.
    # };
  };
}
