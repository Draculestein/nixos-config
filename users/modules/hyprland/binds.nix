{ config, lib, pkgs, ... }:
{
  home.file = {
    ".config/hypr/scripts/increase_volume.sh" = {
      source = ./scripts/increase_volume.sh;
      executable = true;
    };
    ".config/hypr/scripts/decrease_volume.sh" = {
      source = ./scripts/decrease_volume.sh;
      executable = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "foot";
    "$fileManager" = "nautilus";
    "$browser" = "brave";
    "$editor" = "code";

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
      # Workspace
      [
        "$mod, B, exec, $browser"
        "$mod, T, exec, $terminal"
        "$mod, E, exec, $fileManager"
        "$mod, Q, killactive"
        "$mod ALT SHIFT, Delete, exit"
        "$mod, C, exec, $editor"
        "$mod SHIFT, V, togglefloating"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, L, exec, logintcl lock-session"
        "$mod, grave, hyprexpo:expo, toggle # can be: toggle, off/disable or on/enable"
      ]
      ++ builtins.concatLists ws_bindings

      # Media
      ++ [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ]

      # Flameshot
      ++ [
        "CTRL_SHIFT, S, exec, flameshot gui"
      ]

      # Clipse
      ++ [
        "$mod, V, exec, foot --app-id=clipse clipse"
      ]

      # Screen record
      ++ [
        "CTRL ALT SHIFT, R, exec, kooha"
      ];

    bindm = [
      "SUPER, mouse:273, resizewindow"
      "SUPER, mouse:272, movewindow"
    ];

    binde =
      # Media
      [
        ", XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set 33%+"
        ", XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 33%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ", XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/increase_volume.sh"
        ", XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/decrease_volume.sh"
      ];

    # Hyprgrass
    "plugin:touch_gestures" = {
      hyprgrass-bind = [
        ", swipe:4:d, killactive"
        ", swipe:3:l, workspace, e+1"
        ", swipe:3:r, workspace, e-1"

      ];
    };

  };
}
