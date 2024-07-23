{ config, lib, pkgs, ... }:
{
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  services.supergfxd = {
    enable = true;
  };
}
