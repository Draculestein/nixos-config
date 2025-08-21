{ config, lib, pkgs, ... }: {
  services.wluma = {
    enable = true;
    systemd.enable = true;

    settings = {
      als.iio = {
        path = "/sys/bus/iio/devices";
        thresholds = {
          "0" = "night";
          "5" = "dark";
          "15" = "dim";
          "50" = "normal";
          "100" = "bright";
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
}
