{ config, lib, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    mutableExtensionsDir = true;
  };
}
