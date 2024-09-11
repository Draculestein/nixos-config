{ config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.polkit_gnome
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

}
