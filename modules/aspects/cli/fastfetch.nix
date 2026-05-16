{ den, ... }:
{
  den.aspects.fastfetch = {
    homeManager = { config, lib, pkgs, ... }: {
      programs.fastfetch = {
        enable = true;
      };
    };
  };
}
