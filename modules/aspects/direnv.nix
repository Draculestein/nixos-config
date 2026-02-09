{ den, ... }:
{
  den.aspects.direnv = {
    homeManager = { config, lib, pkgs, ... }: {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
        enableBashIntegration = lib.mkIf config.programs.bash.enable true;
      };
    };
  };
}
