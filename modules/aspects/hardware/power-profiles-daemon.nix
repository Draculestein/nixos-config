{ den, ... }:
{
  den.aspects.power-profiles-daemon = {
    nixos = { config, lib, pkgs, ... }: {
      services.power-profiles-daemon.enable = true;
    };
  };
}
