{ den, inputs, ... }:
{
  flake-file.inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri = {
    nixos = { lib, pkgs, ... }: {
      imports = [
        inputs.niri.nixosModules.niri
      ];

      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      security.pam.services.hyprlock = { };
    };

    homeManager = { config, lib, pkgs, osConfig, ... }:
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
        hostname = osConfig.networking.hostName;
        hasAsusKbdBacklight = hostname == "AlbertProP16";
        kbdIdleTimeout = if hostname == "AlbertProP16" then 150 else 300;
      in
      {
        home.packages = [
          pkgs.brightnessctl
          pkgs.xwayland-satellite-unstable
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          pkgs.gpu-screen-recorder
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.inter
        ] ++ lib.optionals hasAsusKbdBacklight [ cycle-keyboard-backlight ];

        services.hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "pidof hyprlock || noctalia-shell ipc call lockScreen lock"; # avoid starting multiple hyprlock instances.
              before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
              after_sleep_cmd = "niri msg action power-on-monitors"; # to avoid having to press a key twice to turn on the display.
            };

            listener = [
              {
                timeout = if hasAsusKbdBacklight then 150 else 300; # 2.5min.
                on-timeout = "brightnessctl -s set 1%"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
                on-resume = "brightnessctl -r"; # monitor backlight restore.
              }

              {
                timeout = 300; # 5min
                on-timeout = "systemd-ac-power || loginctl lock-session"; # lock screen when timeout has passed
              }

              {
                timeout = 330; # 5.5min
                on-timeout = "niri msg action power-off-monitors"; # screen off when timeout has passed
                on-resume = "niri msg action power-on-monitors && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
              }

              {
                timeout = 1200; # 20min
                on-timeout = "systemd-ac-power || systemctl suspend"; # suspend pc
              }
            ] ++ lib.optionals hasAsusKbdBacklight [
              {
                timeout = kbdIdleTimeout;
                on-timeout = "brightnessctl -sd asus::kbd_backlight set 0";
                on-resume = "brightnessctl -rd asus::kbd_backlight";
              }
            ];

          };
        };

        systemd.user.services.hypridle = {
          Unit.PartOf = [ "niri.service" ];
          Install.WantedBy = [ "niri.service" ];
        };

        services.gammastep = {
          enable = true;
          enableVerboseLogging = false;
          provider = "geoclue2";
          temperature = { day = 6500; night = 3000; };
          settings = {
            general = { adjustment-method = "wayland"; fade = 1; };
            wayland = { output = "*DP-*"; };
          };
        };

        programs.niri.settings = {
          debug = {
            render-drm-device = "/dev/dri/amd-igpu";
            honor-xdg-activation-with-invalid-serial = [ ];
          };

          environment = {
            GDK_BACKEND = "wayland,x11,*";
            SDL_VIDEODRIVER = "wayland";
            CLUTTER_BACKEND = "wayland";
            QT_QPA_PLATFORM = "wayland;xcb";
            QT_AUTO_SCREEN_SCALE_FACTOR = "1";
            QT_QPA_PLATFORMTHEME = "qt5ct";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
          };

          spawn-at-startup = [
            { command = [ "noctalia-shell" ]; }
          ];

          input = {
            keyboard = { xkb.layout = "us"; };
            touchpad = { enable = true; tap = true; dwt = true; natural-scroll = true; };
            mouse = { enable = true; };
            trackpoint = { enable = true; };
            touch = { map-to-output = "eDP-1"; };
            tablet = { enable = true; map-to-output = "eDP-1"; };
            focus-follows-mouse = { enable = true; max-scroll-amount = "0%"; };
          };

          outputs = {
            "eDP-1" = {
              enable = true;
              scale = 2.0;
              mode = { width = 3840; height = 2400; refresh = 60.00; };
              position = { x = 1920; y = 0; };
            };
            "ASUSTek COMPUTER INC VG278 M3LMQS154329" = {
              enable = true;
              variable-refresh-rate = "on-demand";
              scale = 1.0;
              mode = { width = 1920; height = 1080; refresh = 164.917; };
              position = { x = 0; y = 0; };
            };
          };

          layout = {
            gaps = 10;
            background-color = "transparent";
            focus-ring = { enable = true; width = 2; };
            border = { enable = true; width = 2; };
            struts = { left = 10; right = 10; top = 0; bottom = 2; };
            tab-indicator = { place-within-column = true; };
          };

          animations = { enable = true; slowdown = 0.9; };
          clipboard.disable-primary = true;
          cursor.hide-when-typing = true;
          hotkey-overlay.skip-at-startup = true;

          window-rules = [
            {
              geometry-corner-radius = { bottom-left = 20.0; bottom-right = 20.0; top-left = 20.0; top-right = 20.0; };
              clip-to-geometry = true;
            }
            {
              matches = [{ app-id = "r#\"firefox$\"#"; title = "^Picture-in-Picture$"; }];
              open-floating = true;
            }
            {
              matches = [{ title = "^Meet - [a-z]{3}-[a-z]{4}-[a-z]{3}$"; } { title = "^(Picture in picture)$"; }];
              open-floating = true;
              default-floating-position = { x = 0; y = 0; relative-to = "top-right"; };
            }
            {
              matches = [{ app-id = "steam"; title = "r#\"^notificationtoasts_\\d+_desktop$\"#"; }];
              default-floating-position = { x = 25; y = 25; relative-to = "bottom-right"; };
            }
            {
              matches = [{ app-id = "zoom"; } { app-id = "XEyes"; } { app-id = "org.kde.polkit-kde-authentication-agent-1"; } { app-id = "com.savedra1.clipse"; }];
              open-floating = true;
            }
            {
              matches = [{ app-id = "code"; }];
              open-maximized = true;
            }
          ];

          layer-rules = [
            { matches = [{ namespace = "^swww-daemon$"; }]; place-within-backdrop = true; }
            { matches = [{ namespace = "^noctalia-wallpaper*"; }]; }
            { matches = [{ namespace = "^noctalia-overview*"; }]; place-within-backdrop = true; }
          ];

          binds = with config.lib.niri.actions; {
            "Mod+Shift+Slash".action = show-hotkey-overlay;

            "Mod+T" = {
              action.spawn = "kitty";
              hotkey-overlay.title = "Open a Terminal: Kitty";
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


            "Mod+L" = {
              action.spawn = [ "loginctl" "lock-session" ];
              hotkey-overlay.title = "Lock session";
            };
            "Mod+Space".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
            "Mod+S".action.spawn = [ "noctalia-shell" "ipc" "call" "settings" "toggle" ];
            "Mod+Q".action = close-window;
            "Mod+Tab" = {
              repeat = false;
              action = toggle-overview;
            };

            "Ctrl+Alt+Delete".action = quit;

            "Mod+Escape" = {
              allow-inhibiting = false;
              action = toggle-keyboard-shortcuts-inhibit;
            };

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
            "Mod+Ctrl+R".action = switch-preset-window-height;

            "Mod+F".action = maximize-column;
            "Mod+Shift+F".action = fullscreen-window;

            "Mod+Equal".action = set-column-width "+5%";
            "Mod+Minus".action = set-column-width "-5%";

            "Mod+Shift+Equal".action = set-window-height "+10%";
            "Mod+Shift+Minus".action = set-window-height "-10%";

            "Mod+V" = {
              action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "clipboard" ];
              hotkey-overlay.title = "Open Clipboard Manager";
            };
            "Mod+Shift+V".action = toggle-window-floating;
            "Alt+Mod+V".action = switch-focus-between-floating-and-tiling;
            "Mod+W".action = toggle-column-tabbed-display;

            "Mod+Shift+S".action.screenshot = [{ show-pointer = true; }];
            "Mod+Shift+R".action.spawn = [ "noctalia-shell" "ipc" "call" "plugin:screen-recorder" "start" ];
            "Ctrl+Mod+Shift+S".action.screenshot-screen = [ ];
            "Alt+Mod+Shift+S".action.screenshot-window = [{ write-to-disk = true; }];

            "Mod+WheelScrollRight" = {
              cooldown-ms = 150;
              action = focus-column-right;
            };

            "Mod+Shift+WheelScrollUp" = {
              action = focus-column-left;
            };

            "Mod+Shift+WheelScrollDown" = {
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

            "Mod+1".action = focus-workspace 1;
            "Mod+2".action = focus-workspace 2;
            "Mod+3".action = focus-workspace 3;
            "Mod+4".action = focus-workspace 4;
            "Mod+5".action = focus-workspace 5;
            "Mod+6".action = focus-workspace 6;
            "Mod+7".action = focus-workspace 7;
            "Mod+8".action = focus-workspace 8;
            "Mod+9".action = focus-workspace 9;

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

            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action.spawn = [ "sh" "-c" "wpctl set-volume -l 1.1 @DEFAULT_AUDIO_SINK@ 5%+" ];
            };

            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action.spawn = [ "sh" "-c" "wpctl set-volume -l 0 @DEFAULT_AUDIO_SINK@ 5%-" ];
            };

            "XF86AudioMute" = {
              allow-when-locked = true;
              action.spawn = [ "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ];
            };

            "XF86AudioMicMute" = {
              allow-when-locked = true;
              action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
            };

            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "increase" ];
            };

            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "decrease" ];
            };

            "XF86KbdBrightnessUp" = {
              allow-when-locked = true;
              action.spawn = [ "brightnessctl" "-d" "asus::kbd_backlight" "set" "+1" ];
            };

            "XF86KbdBrightnessDown" = {
              allow-when-locked = true;
              action.spawn = [ "brightnessctl" "-d" "asus::kbd_backlight" "set" "1-" ];
            };

            "XF86KbdLightOnOff" = {
              allow-when-locked = true;
              action.spawn = "${cycle-keyboard-backlight}/bin/cycle-kbd-backlight";
            };
          };
        };
      };
  };
}
