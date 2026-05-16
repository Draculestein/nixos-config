{ den, ... }:
{
  den.aspects.logitech = {
    nixos = { config, lib, pkgs, ... }: {
      hardware.logitech.wireless.enable = true;
      hardware.logitech.wireless.enableGraphical = true;
    };
  };
}
