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

      "cyrano_production" = {
        host = "98.189.233.116";
        user = "devuser";
        port = 4422;
        identityFile = [ "~/.ssh/cyrano_prod_server" ];
      };
    };
  };

  home.file.".ssh/sockets/.keep".text = "# Managed by Home Manager";
}
