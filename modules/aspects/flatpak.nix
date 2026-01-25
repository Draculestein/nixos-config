{ den, ... }:
{
  den.aspects.flatpak = {
    nixos = { config, lib, pkgs, ... }: {
      services.flatpak.enable = true;
    };
  };
}
