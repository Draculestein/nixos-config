{ config, lib, pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;

    # Fallback portal
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk 
      xdg-desktop-portal-kde
    ];

    config = {

      # Portal for hyprland
      hyprland = {
        default = [
          "hyprland"
          "kde"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.portal.OpenURI" = [ "gtk" ];
        "org.freedesktop.portal.FileChooser" = [ "kde" "gtk" ];
      };

    };
  };
}
