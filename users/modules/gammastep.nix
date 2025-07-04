{ config, lib, pkgs, ... }: {
  services.gammastep = {
    enable = true;
    enableVerboseLogging = true;
    provider = "geoclue2";

    temperature = {
      day = 6500;
      night = 3000;
    };

    settings = {
      general = {
        adjustment-method = "wayland";
        fade = 1;
      };

      wayland = {
        output = "eDP-*";
      };
      
    };
  };
}
