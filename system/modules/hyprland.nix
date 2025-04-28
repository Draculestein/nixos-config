{ config, lib, pkgs, inputs, ... }:
{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;

    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
    kitty
  ];

  programs.iio-hyprland.enable = true;

  security.polkit.enable = true;
  security.pam.services.hyprlock = { };


  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    
    # Fallback portal
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
    ];

    config = {

      # Portal for hyprland
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.portal.FileChooser" = [ "gtk" ];
      };

    };
  };


}
