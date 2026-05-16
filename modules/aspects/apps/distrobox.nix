{ den, ... }:
{
  den.aspects.distrobox = {
    homeManager = { config, lib, pkgs, ... }: {
      programs.distrobox = {
        enable = true;
      };
    };
  };
}
