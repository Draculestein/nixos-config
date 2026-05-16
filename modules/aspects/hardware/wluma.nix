{ den, ... }:
{
  den.aspects.wluma = {
    homeManager = { config, lib, pkgs, ... }: {
      services.wluma = {
        enable = true;
        systemd.enable = true;

        settings = {
          als.iio = {
            path = "/sys/bus/iio/devices";
            thresholds = {
              "0" = "night";
              "20" = "dark";
              "80" = "dim";
              "250" = "normal";
              "500" = "bright";
              "800" = "outdoors";
            };
          };

          output.backlight = [
            {
              name = "eDP-1";
              path = "/sys/class/backlight/amdgpu_bl1";
              capturer = "wayland";
            }
          ];
        };
      };

      systemd.user.services."wluma" = {
        Unit = {
          ConditionEnvironment = lib.mkForce [ "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP=niri" ];
        };
      };
    };
  };
}
