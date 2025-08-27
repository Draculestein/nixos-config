{ config, lib, pkgs, ... }: {
  programs.niri.settings = {
    window-rules = [
      {
        geometry-corner-radius = {
          bottom-left = 20.0;
          bottom-right = 20.0;
          top-left = 20.0;
          top-right = 20.0;
        };
        clip-to-geometry = true;
      }

      {
        matches = [
          {
            app-id = "r#\"firefox$\"#";
            title = "^Picture-in-Picture$";
          }
        ];

        open-floating = true;
      }

      {
        matches = [
          {
            title = "^Meet - [a-z]{3}-[a-z]{4}-[a-z]{3}$";
          }
          {
            title = "^(Picture in picture)$";
          }
        ];

        open-floating = true;
        default-floating-position = {
          x = 0;
          y = 0;
          relative-to = "top-right";
        };
      }

      {
        matches = [
          {
            app-id = "steam";
            title = "r#\"^notificationtoasts_\\d+_desktop$\"#";
          }
        ];

        default-floating-position = {
          x = 25;
          y = 25;
          relative-to = "bottom-right";
        };
      }

      {
        matches = [
          {
            app-id = "zoom";
          }
          {
            app-id = "XEyes";
          }
          {
            app-id = "org.kde.polkit-kde-authentication-agent-1";
          }
          {
            app-id = "com.savedra1.clipse";
          }
        ];

        open-floating = true;
      }

      {
        matches = [
          {
            app-id = "code";
          }
        ];

        default-column-width.proportion = 1.0;
      }
    ];

    layer-rules = [
      {
        matches = [{ namespace = "^swww-daemon$"; }];
        place-within-backdrop = true;
      }

      {
        matches = [{ namespace = "^quickshell-wallpaper$"; }];
      }

      {
        matches = [{ namespace = "^quickshell-overview$"; }];
        place-within-backdrop = true;
      }
    ];

  };
}
