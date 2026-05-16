{ den, ... }:
{
  den.aspects.xbox-controller = {
    nixos = { config, lib, pkgs, ... }: {
      hardware.xpadneo.enable = true;
    };
  };
}
