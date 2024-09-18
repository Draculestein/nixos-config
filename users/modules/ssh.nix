{ config, pkgs, lib, ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = {
      "git" = {
        host = "github.com";
        forwardAgent = true;
        identityFile = [
          "~/.ssh/github_draculestein"
        ];
      };
      "novHaku" = {
        host = "haku.cs.utah.edu";
        user = "novellaalvina";
        port = 5522;
        forwardAgent = true;
      };
    };
  };

  home.file.".ssh/sockets/.keep".text = "# Managed by Home Manager";
}