{ den, ... }:
{
  den.aspects.wacom = {
    nixos = { config, lib, pkgs, ... }: {
      services.xserver.wacom.enable = true;
    };
  };
}
