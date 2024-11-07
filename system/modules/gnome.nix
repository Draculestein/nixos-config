{ config, lib, pkgs, ... }:
{
  services.xserver.desktopManager.gnome.enable = true;
  services.power-profiles-daemon.enable = false;
}

