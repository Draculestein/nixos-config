{ den, ... }:
{
  den.aspects.zsh = {
    homeManager = { pkgs, lib, config, ... }: {
      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        initContent = builtins.readFile ./.zshrc;

        zplug = {
          enable = true;
          plugins = [
            { name = "Aloxaf/fzf-tab"; }
          ];
        };
      };

      programs.lsd = {
        enable = true;
      };

      programs.bat.enable = true;

      programs.starship = {
        enable = true;
        enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
        enableBashIntegration = lib.mkIf config.programs.bash.enable true;
      };

      programs.bash = {
        enable = true;
      };
    };
  };
}
