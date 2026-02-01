{ den, ... }:
{
  den.aspects.powertop = {
    nixos = { config, lib, pkgs, ... }: {
      powerManagement.powertop.enable = true;
    };
  };
}
