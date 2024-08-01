{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = builtins.readFile ./.zshrc;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
}
