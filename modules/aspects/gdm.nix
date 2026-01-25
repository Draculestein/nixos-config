{ den, ... }:
{
  den.aspects.gdm = {
    nixos = { config, lib, pkgs, ... }: {
      services.displayManager.gdm.enable = true;
    };
  };
}
