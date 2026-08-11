{ den, inputs, ... }:
{
  flake-file.inputs.wluma.url = "github:max-baz/wluma";

  den.aspects.wluma = {
    homeManager = { config, lib, pkgs, ... }: {
      # wluma drives external DDC monitors (e.g. the VG278 on DisplayPort)
      # by shelling out to the `ddcutil` CLI (its direct ddc_hi path is
      # unreliable over amdgpu DP-AUX). Without ddcutil on PATH it spams
      # "Unable to execute ddcutil detect". This lands in
      # /etc/profiles/per-user/$USER/bin, which is on the wluma service PATH.
      home.packages = [ pkgs.ddcutil ];

      services.wluma = {
        enable = true;
        systemd.enable = true;
        package = inputs.wluma.defaultPackage.${pkgs.stdenv.hostPlatform.system};

        settings = {
          als.iio = {
            thresholds = {
              "0" = "night";
              "20" = "dark";
              "80" = "dim";
              "250" = "normal";
              "500" = "bright";
              "800" = "outdoors";
            };
          };
        };
      };

      systemd.user.services."wluma" = {
        Unit = {
          ConditionEnvironment = lib.mkForce [
            "WAYLAND_DISPLAY"
            "|XDG_CURRENT_DESKTOP=niri"
            "|XDG_CURRENT_DESKTOP=mango"
          ];
        };
      };
    };
  };
}
