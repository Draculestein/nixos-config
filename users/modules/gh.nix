{config, lib, pkgs, ...}:
{
  programs.gh = {
    enable = true;
    gitCredentialHelper = true;
  };
}