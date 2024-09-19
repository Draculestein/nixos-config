{ config, lib, pkgs, ... }:
{
  home.file = {
    ".config/hypr/scripts/increase_volume.sh".source = ../scripts/increase_volume.sh;
    ".config/hypr/scripts/decrease_volume.sh".source = ../scripts/decrease_volume.sh;
  };

  wayland.windowManager.hyprland = {
    settings = {
      # ======== Binds ========
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
        [
          "$mod, B, exec, $browser"
          "$mod, T, exec, $terminal"
          "$mod, E, exec, $fileManager"
          "$mod, Q, killactive"
          "$mod ALT SHIFT, Delete, exit"
          "$mod, C, exec, $editor"
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
          ", XF86AudioRaiseVolume, exec, ./scripts/increase_volume.sh"
          ", XF86AudioLowerVolume, exec, ./scripts/decrease_volume.sh"
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
