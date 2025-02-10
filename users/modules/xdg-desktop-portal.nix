{ config, lib, pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;

    # Fallback portal
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config = { 
      common = {
        default = [
          "gtk"
        ];
      };
    };
  };
}
