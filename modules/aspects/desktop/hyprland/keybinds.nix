{ den, ... }: {
  den.aspects.hyprland.provides.keybinds = {
    homeManager = { ... }: {
      wayland.windowManager.hyprland.settings = {
        bind = [
          # App launchers
          "SUPER, T, exec, kitty"
          "SUPER, B, exec, brave"
          "SUPER, E, exec, nautilus"
          "SUPER, C, exec, code"

          # Session
          "SUPER, L, exec, loginctl lock-session"
          "SUPER, Space, exec, noctalia-shell ipc call launcher toggle"
          "SUPER, S, exec, noctalia-shell ipc call settings toggle"
          "SUPER, Q, killactive"
          "CTRL ALT, Delete, exit"

          # Focus
          "SUPER, Left, layoutmsg, move -col"
          "SUPER, Right, layoutmsg, move +col"
          "SUPER, Up, movefocus, u"
          "SUPER, Down, movefocus, d"

          # Move windows
          "SUPER SHIFT, Left, layoutmsg, swapcol l"
          "SUPER SHIFT, Right, layoutmsg, swapcol r"
          "SUPER SHIFT, Up, movewindow, u"
          "SUPER SHIFT, Down, movewindow, d"

          # Groups (analogous to niri columns)
          "SUPER, bracketleft, moveintogroup, l"
          "SUPER, bracketright, moveintogroup, r"
          "SUPER, comma, moveintogroup, d"
          "SUPER, period, moveoutofgroup"

          # Layout
          "SUPER, R, pseudo"
          "SUPER, F, fullscreen, 1"
          "SUPER, W, togglegroup"

          # Floating
          "SUPER, V, exec, noctalia-shell ipc call launcher clipboard"
          "SUPER SHIFT, V, togglefloating"
          "ALT SUPER, V, cyclenext, floating"

          # Screenshots
          "SUPER SHIFT, S, exec, grimblast copy area"
          "SUPER SHIFT, A, exec, wl-paste | satty -f -"
          "SUPER SHIFT, R, exec, noctalia-shell ipc call plugin:screen-recorder start"
          "CTRL SUPER SHIFT, S, exec, grimblast copy screen"
          "ALT SUPER SHIFT, S, exec, grimblast save active"

          # Workspaces
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"

          "SUPER CTRL, Up, workspace, e-1"
          "SUPER CTRL, Down, workspace, e+1"
          "SUPER SHIFT CTRL, Up, movetoworkspace, e-1"
          "SUPER SHIFT CTRL, Down, movetoworkspace, e+1"

          # Resize
          "SUPER, equal, resizeactive, 50 0"
          "SUPER, minus, resizeactive, -50 0"
          "SUPER SHIFT, equal, resizeactive, 0 50"
          "SUPER SHIFT, minus, resizeactive, 0 -50"

          # Mouse scroll focus
          "SUPER, mouse_up, movefocus, u"
          "SUPER, mouse_down, movefocus, d"
          "SUPER SHIFT, mouse_up, movefocus, l"
          "SUPER SHIFT, mouse_down, movefocus, r"
          "SUPER CTRL, mouse_up, workspace, e-1"
          "SUPER CTRL, mouse_down, workspace, e+1"
        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        bindle = [
          # Volume (works when locked)
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 0 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          # Brightness (works when locked)
          ", XF86MonBrightnessUp, exec, noctalia-shell ipc call brightness increase"
          ", XF86MonBrightnessDown, exec, noctalia-shell ipc call brightness decrease"
        ];

        bindl = [
          # Keyboard backlight (works when locked)
          ", XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set +1"
          ", XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 1-"
          ", XF86KbdLightOnOff, exec, brightnessctl -d asus::kbd_backlight set $(( ($(brightnessctl -d asus::kbd_backlight get) + 1) % ($(brightnessctl -d asus::kbd_backlight max) + 1) ))"
        ];
      };
    };
  };
}
