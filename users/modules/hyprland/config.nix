{ config, lib, pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;

    systemd.variables = [ "--all" ];

    settings = {
      # ======== Environment ========
      env = [
        "GDK_BACKEND, wayland,x11,*"
        "QT_QPA_PLATFORM, wayland;xcb"
        "SDL_VIDEODRIVER, wayland"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "XCURSOR_SIZE, 24"
        "SSH_AUTH_SOCK, $XDG_RUNTIME_DIR/keyring/ssh"
      ];

      # ======== Autostart ========
      exec-once = [
        "hyprpaper &"
        "systemctl start --user my-polkit-gnome-authentication-agent-1 &"
        "systemctl start --user start-gnome-keyring-daemon &"
        "ags"
      ];

      # ======== Monitor ========
      monitor = [
        "eDP-1, 1920x1200@60, 0x0, 1"
        "DP-1, 1920x1080@164.92, -1920x0, 1"
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

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
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
      };

      # ======== Binds ========
      "$mod" = "SUPER";
      "$terminal" = "foot";
      "$fileManager" = "nautilus";
      "$browser" = "brave";

      bind =
        let
          ws = number: ws_number: "$mod, ${number}, workspace, ${ws_number}";
          move_to_ws = number: ws_number: "$mod SHIFT, ${number}, movetoworkspace, ${ws_number}";
          ws_capacity = 10;
          ws_bindings = builtins.genList
            (i:
              let
                ws_number = i + 1;
                key = if ws_number == 10 then 0 else ws_number;
              in
              [
                "${ws (toString key)(toString ws_number)}"
                "${move_to_ws (toString key)(toString ws_number)}"
              ]
            )
            ws_capacity;
        in
        [
          "$mod, B, exec, $browser"
          "$mod, T, exec, $terminal"
          "$mod, E, exec, $fileManager"
          "$mod, Q, killactive"
          "$mod ALT SHIFT, Delete, exit"
          "$mod, V, togglefloating"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          ", XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set 33%+"
          ", XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 33%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"


        ]
        ++ builtins.concatLists ws_bindings;

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      # ======== Windowrules ========
      windowrulev2 = [
        "suppressevent maximize, class:.*" # You'll probably like this.
      ];

    };
  };
}
