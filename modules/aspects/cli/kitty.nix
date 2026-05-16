{ den, ... }:
{
  den.aspects.kitty = {
    homeManager = { config, lib, ... }: {
      programs.kitty = {
        enable = true;
        enableGitIntegration = true;
        shellIntegration = {
          enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
          enableBashIntegration = lib.mkIf config.programs.bash.enable true;
        };
      };
    };
  };
}
