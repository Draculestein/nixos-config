{ den, ... }:
{
  den.aspects.direnv = {
    homeManager = { config, lib, pkgs, ... }: {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
    };
  };
}
