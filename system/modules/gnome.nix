{ config, lib, pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];

    config = {
      gnome = {
        default = [
          "gnome"
        ];
      };
    };
  };
}

