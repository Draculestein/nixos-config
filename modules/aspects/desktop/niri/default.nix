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
        hasAsusKbdBacklight = osConfig.networking.hostName == "AlbertProP16";
      in
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

        ] ++ lib.optionals hasAsusKbdBacklight [ cycle-keyboard-backlight ];


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

            # Re-render a Kvantum theme from the active Noctalia palette on every
            # theme change. Kvantum (unlike the qt5ct/qt6ct Fusion palette) is
            # honored by KDE apps such as Okular, so this is what actually themes
            # them. The static parts (the SVG, the kvantum.kvconfig selector and
            # this template input) are provisioned via home-manager in
            # users/albertjul.nix.
            theme.templates.user.kvantum = {
              input_path = "${config.home.homeDirectory}/.config/noctalia/templates/Noctalia.kvconfig";
              output_path = "${config.home.homeDirectory}/.config/Kvantum/Noctalia/Noctalia.kvconfig";
            };
          };
        };

        xdg.configFile = {
          "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/.dotfiles/modules/aspects/desktop/niri/config.kdl";
          "niri/keybinds.kdl".source = config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/.dotfiles/modules/aspects/desktop/niri/keybinds.kdl";
          "niri/window-rules.kdl".source = config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/.dotfiles/modules/aspects/desktop/niri/window-rules.kdl";
        };
      };
  };
}
