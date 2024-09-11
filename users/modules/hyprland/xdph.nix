{ config, lib, pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    # Fallback portal
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

    config = {
      
      # Portal for hyprland
      hyprland = {
        default = [
          "xdph"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.portal.FileChooser" = [ "xdg-desktop-portal-gtk" ];
      };

    };
  };
}
