{ config, lib, pkgs, ... }: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Shift+Slash".action = show-hotkey-overlay;

    "Mod+T" = {
      action.spawn = "ghostty";
      hotkey-overlay.title = "Open a Terminal: Ghostty";
    };

    "Mod+B" = {
      action.spawn = "brave";
      hotkey-overlay.title = "Open a Browser: Brave";
    };

    "Mod+E" = {
      action.spawn = "nautilus";
      hotkey-overlay.title = "Open a File Explorer: Nautilus";
    };

    "Mod+C" = {
      action.spawn = "code";
      hotkey-overlay.title = "Open a Editor: Visual Studio Code";
    };

    "Mod+Alt+L" = {
      action.spawn = "swaylock";
      hotkey-overlay.title = "Lock the Screen: swaylock";
    };

    "Mod+Q".action = close-window;
    "Mod+Tab" = {
      repeat = false;
      action = toggle-overview;
    };

    "Ctrl+Alt+Delete".action = quit;

    # Inhibits
    "Mod+Escape" = {
      allow-inhibiting = false;
      action = toggle-keyboard-shortcuts-inhibit;
    };

    # Columns & Windows
    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Up".action = focus-window-up;
    "Mod+Down".action = focus-window-down;

    "Mod+Shift+Left".action = move-column-left;
    "Mod+Shift+Right".action = move-column-right;
    "Mod+Shift+Up".action = move-window-up;
    "Mod+Shift+Down".action = move-window-down;

    "Mod+BracketLeft".action = consume-or-expel-window-left;
    "Mod+BracketRight".action = consume-or-expel-window-right;

    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;

    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;

    "Mod+Plus".action = set-column-width "+10%";
    "Mod+Minus".action = set-column-width "-10%";

    # "Mod+Shift+Plus".action = set-column-height "+10%";
    # "Mod+Shift+Minus".action = set-column-height "-10%";

    "Mod+V".action = toggle-window-floating;
    "Mod+W".action = toggle-column-tabbed-display;

    "Mod+Shift+S".action = screenshot {show-pointer = true; };
    # "Ctrl+Mod+Shift+S".action = screenshot-screen;
    "Alt+Mod+Shift+S".action = screenshot-window { write-to-disk = true; };

    "Mod+WheelScrollRight" = {
      cooldown-ms = 150;
      action = focus-column-right;
    };

    "Mod+WheelScrollLeft" = {
      cooldown-ms = 150;
      action = focus-column-left;
    };

    "Mod+WheelScrollUp" = {
      cooldown-ms = 150;
      action = focus-window-up;
    };

    "Mod+WheelScrollDown" = {
      cooldown-ms = 150;
      action = focus-window-down;
    };

    # Workspaces
    "Mod+1".action = focus-workspace 1;
    "Mod+2".action = focus-workspace 2;
    "Mod+3".action = focus-workspace 3;
    "Mod+4".action = focus-workspace 4;
    "Mod+5".action = focus-workspace 5;
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;

    # "Mod+Shift+1".action = move-column-to-workspace 1;
    # "Mod+Shift+2".action = move-column-to-workspace 2;
    # "Mod+Shift+3".action = move-column-to-workspace 3;
    # "Mod+Shift+4".action = move-column-to-workspace 4;
    # "Mod+Shift+5".action = move-column-to-workspace 5;
    # "Mod+Shift+6".action = move-column-to-workspace 6;
    # "Mod+Shift+7".action = move-column-to-workspace 7;
    # "Mod+Shift+8".action = move-column-to-workspace 8;
    # "Mod+Shift+9".action = move-column-to-workspace 9;

    "Mod+Ctrl+WheelScrollUp" = {
      cooldown-ms = 150;
      action = focus-workspace-up;
    };

    "Mod+Ctrl+WheelScrollDown" = {
      cooldown-ms = 150;
      action = focus-workspace-down;
    };

    # Audio
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
    };

    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
    };

    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
    };

    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
    };    

    # Screen brightness
    "XF86MonBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "-d" "amdgpu_bl1" "set" "+5%"];
    };

     "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "-d" "amdgpu_bl1" "set" "5%-"];
    };

    # Keyboard backlight
    "XF86KbdBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "-d" "asus::kbd_backlight" "set" "+1"];
    };

     "XF86KbdBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "-d" "asus::kbd_backlight" "set" "1-"];
    };
  };
}
