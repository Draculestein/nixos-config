{ den, ... }:
{
  den.aspects.zoom-us = {
    nixos = { config, lib, pkgs, ... }: {
      programs.zoom-us = {
        enable = true;
      };
    };
  };
}
