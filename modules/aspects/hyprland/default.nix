{ den, inputs, ... }: {
  flake-file.inputs = {
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.54.3";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  den.aspects.hyprland = {
    includes = [
      den.aspects.hyprland._.keybinds
      den.aspects.hyprland._.appearance
    ];

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

            input = {
              kb_layout = "us";

              touchpad = {
                natural_scroll = true;
                clickfinger_behavior = true;
              };
            };

            scrolling = {
              fullscreen_on_one_column = true;
              column_width = 0.9;
              direction = "right";
              focus_fit_method = 1;
            };

            layerrule = {
              name = "noctalia";
              "match:namespace" = "noctalia-background-.*$";
              ignore_alpha = 0.5;
              blur = true;
              blur_popups = true;
            };

            gesture = [
              "3, vertical, workspace"
              "3, right, dispatcher, layoutmsg, move -col"
              "3, left, dispatcher, layoutmsg, move +col"
            ];
          };
        };
      };
  };
}
