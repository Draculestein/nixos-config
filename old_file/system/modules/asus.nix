{ config, lib, pkgs, ... }:
{
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  services.supergfxd = {
    enable = true;
  };

  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };

  services.power-profiles-daemon.enable = true;

}
