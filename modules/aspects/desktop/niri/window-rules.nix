{ den, ... }:
{
  den.aspects.niri.provides.window-rules = {
    homeManager = { ... }: {
      programs.niri.settings = {
        window-rules = [
          {
            geometry-corner-radius = { bottom-left = 20.0; bottom-right = 20.0; top-left = 20.0; top-right = 20.0; };
            clip-to-geometry = true;
          }
          {
            matches = [{ app-id = "dev.noctalia.Noctalia.Settings"; }];
            open-floating = true;
            default-column-width.fixed = 1080;
            default-window-height.fixed = 920;
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
            matches = [{ app-id = "zoom"; } { app-id = "XEyes"; } { app-id = "org.kde.polkit-kde-authentication-agent-1"; }];
            open-floating = true;
          }
          {
            matches = [{ app-id = "org.gnome.NautilusPreviewer"; }];
            open-floating = true;
            default-window-height.proportion = 1.00;
          }
          {
            matches = [{ app-id = "code"; }];
            open-maximized = true;
          }
          {
            matches = [{ app-id = "slack"; }];
            open-on-workspace = "work-secondary";
          }
          {
            matches = [{ app-id = "Spotify"; }];
            open-on-workspace = "media";
          }
          {
            matches = [{ app-id = "thunderbird"; }];
            open-on-workspace = "personal-monitor";
          }
        ];

        layer-rules = [
          { matches = [{ namespace = "^noctalia-backdrop*"; }]; place-within-backdrop = true; }
          # {
          #   matches = [{ namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel)$"; }];
          #   background-effect = {
          #     xray = false;
          #   };
          # }
        ];
      };
    };
  };
}
