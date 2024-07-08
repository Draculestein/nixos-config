{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    initExtra = builtins.readFile ./.zshrc;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
}
