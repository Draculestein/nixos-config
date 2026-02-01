{ den, ... }:
{
  den.aspects.blueman = {
    nixos = { config, lib, pkgs, ... }: {
      services.blueman.enable = true;
    };
  };
}
