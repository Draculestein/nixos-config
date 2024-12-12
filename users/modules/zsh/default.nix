{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = builtins.readFile ./.zshrc;

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "c7fb028ec0bbc1056c51508602dbd61b0f475ac3";
          sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
        };
      }
    ];
  };

  programs.lsd = {
    enable = true;
    # enableAliases = true;
  };

  programs.bat.enable = true;
}
