{ config, lib, pkgs, ... }:
let
  cycle-keyboard-backlight = pkgs.writeShellApplication {
    name = "cycle-kbd-backlight";
    runtimeInputs = [
      pkgs.brightnessctl
    ];
    text = ''
      # Get the current keyboard backlight level
      current=$(brightnessctl -d asus::kbd_backlight get)
      max=$(brightnessctl -d asus::kbd_backlight max)

      # Calculate the next level (cycle from 0 to 3)
      next=$(( (current + 1) % (max + 1) ))

      # Set the new backlight level
      brightnessctl -d asus::kbd_backlight set "$next"
    '';
  };
in
{
  home.packages = [
    cycle-keyboard-backlight
  ];

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

    "Mod+L".action.spawn = [ "loginctl" "lock-session" ];
    "Mod+Space".action.spawn = "fuzzel";
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
    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;

    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;

    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;

    "Mod+Equal".action = set-column-width "+10%";
    "Mod+Minus".action = set-column-width "-10%";

    "Mod+Shift+Equal".action = set-window-height "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";

    "Mod+V".action = toggle-window-floating;
    "Alt+Mod+V".action = switch-focus-between-floating-and-tiling;
    "Mod+W".action = toggle-column-tabbed-display;

    "Mod+Shift+S".action = screenshot { show-pointer = true; };
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

    "Mod+Ctrl+Up".action = focus-workspace-up;
    "Mod+Ctrl+Down".action = focus-workspace-down;
    "Mod+Shift+Ctrl+Up".action = move-column-to-workspace-up;
    "Mod+Shift+Ctrl+Down".action = move-column-to-workspace-down;

    # Audio
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [ "sh" "-c" "wpctl set-volume -l 1.1 @DEFAULT_AUDIO_SINK@ 5%+ && ignis open-window OnScreenDisplay" ];
    };

    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [ "sh" "-c" "wpctl set-volume -l 0 @DEFAULT_AUDIO_SINK@ 5%- && ignis open-window OnScreenDisplay" ];
    };

    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [ "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ignis open-window OnScreenDisplay" ];
    };

    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
    };

    # Screen brightness
    "XF86MonBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "-d" "amdgpu_bl1" "set" "+5%" ];
    };

    "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "-d" "amdgpu_bl1" "set" "5%-" ];
    };

    # Keyboard backlight
    "XF86KbdBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "-d" "asus::kbd_backlight" "set" "+1" ];
    };

    "XF86KbdBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "-d" "asus::kbd_backlight" "set" "1-" ];
    };

    "XF86KbdLightOnOff" =
      {
        allow-when-locked = true;
        action.spawn = "${cycle-keyboard-backlight}/bin/cycle-kbd-backlight";

      };
  };
}
