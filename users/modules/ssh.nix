{ config, pkgs, lib, ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "git" = {
        host = "github.com";
        forwardAgent = true;
        identityFile = [
          "~/.ssh/github_draculestein"
        ];
      };
    };
  };

  home.file.".ssh/sockets/.keep".text = "# Managed by Home Manager";
}