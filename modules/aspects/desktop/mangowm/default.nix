{ den, inputs, ... }:
{
  flake-file.inputs = {
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
    };

  };

  den.aspects.mangowm = {
    nixos = {
      imports = [
        inputs.mango.nixosModules.mango
      ];

      programs.mango.enable = true;
    };

    homeManager = { pkgs, lib, osConfig, ... }:
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
          inputs.mango.hmModules.mango
        ];

        home.packages = [
          pkgs.brightnessctl
          pkgs.xwayland-satellite-unstable
          pkgs.gpu-screen-recorder
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.inter
          pkgs.wl-clipboard
          pkgs.satty
        ] ++ lib.optionals hasAsusKbdBacklight [ cycle-keyboard-backlight ];


        xdg.portal = {
          enable = lib.mkForce true;
          extraPortals = [
            pkgs.xdg-desktop-portal-wlr
            pkgs.xdg-desktop-portal-gtk
            pkgs.gnome-keyring
          ];
          config.mango = {
            default = [ "gtk" ];
            "org.freedesktop.impl.portal.Screencast" = [ "gtk" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "gtk" ];
            "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          };
        };

        wayland.windowManager.mango = {
          enable = true;

          systemd = {
            enable = true;
            variables = [ "--all" ];
          };

          settings = {
            exec-once = [ "noctalia" ];
            env = [
              "GDK_BACKEND,wayland,x11,*"
              "SDL_VIDEODRIVER,wayland,x11"
              "CLUTTER_BACKEND,wayland"
              "QT_QPA_PLATFORM,wayland;xcb"
              "QP_AUTO_SCREEN_SCALE_FACTOR,1"
              "QT_QPA_PLATFORM_THEME,qt6ct;qt5ct"
              "ELECTRON_OZONE_PLATFORM_HINT,auto"
            ];

            monitorrule = [
              "model:HP M24h,width:1920,height:1080,refresh:60.00,x:0,y:0,scales:1.0,rr:1"
              "model:VG278,width:1920,height:1080,refresh:164.917,x:1080,y:0,scales:1.0,rr:0"
              "name:^eDP-1$,width:3840,height:2400,refresh:60.00,x:3000,y:0,scale:2.0,rr:0"
            ];

            xkb_rules_layout = "us";
            trackpad_natural_scrolling = 1;
            click_method = 2; # Double tap for right click
            xwayland_persistence = 1;
          };
        };
      };
  };
}
