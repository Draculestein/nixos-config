{ den, inputs, ... }:
{
  flake-file.inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
    };

    nfsm-flake = {
      url = "github:gvolpe/nfsm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri = {
    includes = [
      den.aspects.niri._.keybinds
      den.aspects.niri._.window-rules
      den.aspects.niri._.idle
    ];

    nixos = { pkgs, ... }: {
      imports = [
        inputs.niri.nixosModules.niri
      ];

      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      services.gnome.gnome-keyring.enable = true;

      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };
    };

    homeManager = { config, lib, pkgs, osConfig, ... }:
      {
        imports = [
          inputs.nfsm-flake.homeModules.default
          inputs.noctalia.homeModules.default
          ../_hypridle.nix
        ];

        home.packages = [
          pkgs.brightnessctl
          pkgs.xwayland-satellite-unstable
          pkgs.gpu-screen-recorder
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.inter
          pkgs.wl-clipboard
          pkgs.satty
          pkgs.polkit_gnome
        ];

        services.gammastep = {
          enable = true;
          enableVerboseLogging = false;
          # provider = "geoclue2";
          provider = "manual";
          dawnTime = "05:30";
          duskTime = "18:00";
          temperature = { day = 6500; night = 3500; };
          settings = {
            general = { adjustment-method = "wayland"; fade = 1; };
            wayland = { output = "*DP-*"; };
          };
        };

        systemd.user.services.nfsm = {
          Unit = {
            PartOf = [ "niri.service" ];
            After = [ "niri.service" ];
            Requires = [ "niri.service" ];
          };
          Install.WantedBy = [ "niri.service" ];
        };

        services.nfsm = {
          enable = true;
        };

        xdg.portal = {
          enable = lib.mkForce true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-gnome
            pkgs.gnome-keyring
          ];
          config.niri = {
            default = [ "gnome" "gtk" ];
            "org.freedesktop.impl.portal.Access" = [ "gtk" ];
            "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
            "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          };
        };

        systemd.user.services.niri-flake-polkit = {
          Install.WantedBy = lib.mkForce [ "niri.service" ];
          Unit = {
            Description = lib.mkForce "PolicyKit Authentication Agent (polkit_gnome)";
            After = lib.mkForce [ "graphical-session.target" ];
            PartOf = lib.mkForce [ "graphical-session.target" ];
          };
          Service = {
            Type = lib.mkForce "simple";
            ExecStart = lib.mkForce "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = lib.mkForce "on-failure";
            RestartSec = lib.mkForce 1;
            TimeoutStopSec = lib.mkForce 10;
          };
        };

        programs.noctalia = {
          enable = true;
          package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

          settings = {
            wallpaper = {
              enabled = true;
              directory = "/home/albertjul/Pictures/Wallpapers";

              automation = {
                enabled = true;
                interval_minutes = 15;
                order = "random";
                recursive = true;
              };
            };
          };
        };

        programs.niri.settings = {
          debug = {
            render-drm-device = "/dev/dri/amd-igpu";
            honor-xdg-activation-with-invalid-serial = [ ];
          };

          environment = {
            GDK_BACKEND = "wayland,x11,*";
            SDL_VIDEODRIVER = "wayland,x11";
            CLUTTER_BACKEND = "wayland";
            QT_QPA_PLATFORM = "wayland;xcb";
            QT_AUTO_SCREEN_SCALE_FACTOR = "1";
            QT_QPA_PLATFORMTHEME = "qt5ct";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
          };

          spawn-at-startup = [
            { command = [ "noctalia" ]; }
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

            "HP Inc. HP M24h 3CM3120S60" = {
              enable = true;
              scale = 1.0;
              mode = { width = 1920; height = 1080; refresh = 60.000; };
              position = { x = -1920; y = 0; };
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

          workspaces = {
            "media" = { open-on-output = "eDP-1"; };
            "personal-monitor" = {
              open-on-output = "ASUSTek COMPUTER INC VG278 M3LMQS154329";
            };
            "personal-secondary" = { open-on-output = "eDP-1"; };
            "work-monitor" = {
              open-on-output = "ASUSTek COMPUTER INC VG278 M3LMQS154329";
            };
            "work-secondary" = { open-on-output = "eDP-1"; };
          };

          animations = { enable = true; slowdown = 0.9; };
          clipboard.disable-primary = true;
          cursor = {
            theme = "Capitaine Cursors (Palenight)";
            size = 16;
            hide-when-typing = true;
          };
          hotkey-overlay.skip-at-startup = true;
        };
      };
  };
}
