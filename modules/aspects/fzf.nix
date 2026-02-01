{ den, ... }:
{
  den.aspects.fzf = {
    homeManager = { config, lib, pkgs, ... }: {
      programs.fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
