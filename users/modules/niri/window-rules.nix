{ config, lib, pkgs, ... }: {
  programs.niri.settings = {
    window-rules = [
      {
        geometry-corner-radius = {
          bottom-left = 12.0;
          bottom-right = 12.0;
          top-left = 12.0;
          top-right = 12.0;
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
          x = 10;
          y = 10;
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
        ];

        open-floating = true;
      }
    ];

  };
}
