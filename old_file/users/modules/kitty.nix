{config, lib, pkgs, ...}: {
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration = {
      enableZshIntegration = true;
    };
  };
}