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
    ];

  };
}