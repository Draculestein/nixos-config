{ den, inputs, ... }:
{
  flake-file.inputs.wluma.url = "github:max-baz/wluma";

  den.aspects.wluma = {
    homeManager = { config, lib, pkgs, ... }: {
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
