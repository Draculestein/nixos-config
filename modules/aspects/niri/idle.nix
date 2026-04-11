{ den, ... }:
{
  den.aspects.niri.provides.idle = {
    homeManager = { lib, osConfig, ... }:
      let
        hostname = osConfig.networking.hostName;
        hasAsusKbdBacklight = hostname == "AlbertProP16";
        kbdIdleTimeout = if hostname == "AlbertProP16" then 150 else 300;
      in
      {
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
      };
  };
}
