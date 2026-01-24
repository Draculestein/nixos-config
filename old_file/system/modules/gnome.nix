{ config, lib, pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;
  systemd.user.services.orca.wantedBy = lib.mkForce [ ];
  
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

