{ den, ... }:
{
  den.aspects.plasma6 = {
    nixos = { config, lib, pkgs, ... }: {
      services.desktopManager.plasma6.enable = true;
    };
  };
}
