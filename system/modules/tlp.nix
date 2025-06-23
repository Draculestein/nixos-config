{ config, lib, pkgs, ... }:
{
  services.power-profiles-daemon.enable = lib.mkForce false;
  services.tlp.enable = true;
  services.tlp.settings = {
    USB_AUTOSUSPEND = 0;
    TLP_DEFAULT_MODE = "BAT";
    RUNTIME_PM_DRIVER_DENYLIST = "mei_me";
    RUNTIME_PM_ON_AC = "auto";
    RUNTIME_PM_ENABLE = "64:00.0";
  };
}
