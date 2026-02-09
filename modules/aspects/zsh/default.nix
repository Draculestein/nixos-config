{ den, ... }:
{
  den.aspects.zsh = {
    homeManager = { pkgs, lib, config, ... }: {
      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        initContent = builtins.readFile ./.zshrc;

        plugins = [
          {
            name = "fzf-tab";
            src = pkgs.fetchFromGitHub {
              owner = "Aloxaf";
              repo = "fzf-tab";
              rev = "6aced3f35def61c5edf9d790e945e8bb4fe7b305";
              sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
            };
          }
        ];
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
