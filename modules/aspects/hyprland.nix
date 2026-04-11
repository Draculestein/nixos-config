{ den, inputs, ... }: {
  flake-file.inputs = {
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.54.3";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  den.aspects.hyprland = {
    nixos = { pkgs, ... }: {
      programs.hyprland = {
        enable = true;
        # set the flake package
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        # make sure to also set the portal package, so that they are in sync
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };

    homeManager = { config, lib, pkgs, osConfig, ... }:
      {
        home.packages = [
          pkgs.brightnessctl
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          pkgs.gpu-screen-recorder
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.inter
          pkgs.wl-clipboard
          pkgs.grimblast
          pkgs.satty
        ];

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

        xdg.portal = {
          enable = lib.mkForce true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
            pkgs.gnome-keyring
          ];
          config.hyprland = {
            default = [ "hyprland" "gtk" ];
          };
        };

        services.hyprpaper.enable = lib.mkForce false; # Wallpaper handled by noctalia-shell

        wayland.windowManager.hyprland = {
          enable = true;
          package = null; # Follow the host-level defined package
          portalPackage = null;
          systemd.variables = [ "--all" ];

          settings = {
            env = [
              "AQ_DRM_DEVICES,/dev/dri/amd-igpu"
              "GDK_BACKEND,wayland,x11,*"
              "QT_QPA_PLATFORM,wayland;xcb"
              "SDL_VIDEODRIVER,wayland,x11"
              "CLUTTER_BACKEND,wayland"
              "QT_AUTO_SCREEN_SCALE_FACTOR,1"
              "QT_QPA_PLATFORMTHEME,qt5ct"
              "ELECTRON_OZONE_PLATFORM_HINT,auto"

              "XDG_CURRENT_DESKTOP,Hyprland"
              "XDG_SESSION_TYPE,wayland"
              "XDG_SESSION_DESKTOP,Hyprland"
            ];

            exec-once = [
              "noctalia-shell"
            ];

            monitor = [
              "eDP-1, 3840x2400@60.00, 1920x0, 2.0"
              "desc:ASUSTek COMPUTER INC VG278 M3LMQS154329, 1920x1080@164.917, 0x0, 1.0"
            ];

            general = {
              border_size = 4;
              gaps_in = 5;
              gaps_out = 10;
              layout = "scrolling";
              resize_on_border = true;
              locale = "en_US";
            };

            decoration = {
              rounding = 20;
              rounding_power = 2;

              shadow = {
                enabled = true;
                range = 4;
                render_power = 3;
              };

              blur = {
                enabled = true;
                size = 3;
                passes = 2;
                vibrancy = 0.1696;
              };
            };

            input = {
              kb_layout = "us";

              touchpad = {
                natural_scroll = true;
                clickfinger_behavior = true;
              };
            };

            cursor = {
              no_hardware_cursors = 0;
            };

            layerrule = {
              name = "noctalia";
              "match:namespace" = "noctalia-background-.*$";
              ignore_alpha = 0.5;
              blur = true;
              blur_popups = true;
            };

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
              "SUPER, Left, movefocus, l"
              "SUPER, Right, movefocus, r"
              "SUPER, Up, movefocus, u"
              "SUPER, Down, movefocus, d"

              # Move windows
              "SUPER SHIFT, Left, movewindow, l"
              "SUPER SHIFT, Right, movewindow, r"
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
  };
}

