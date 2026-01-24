{ config, pkgs, lib, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };

      "git" = {
        host = "github.com";
        forwardAgent = true;
        identityFile = [
          "~/.ssh/github_draculestein"
        ];

        addKeysToAgent = "yes";
      };

      "cyrano_production" = {
        host = "98.189.233.116";
        user = "devuser";
        port = 4422;
        identityFile = [ "~/.ssh/cyrano_prod_server" ];
        forwardAgent = true;
        addKeysToAgent = "yes";
      };
    };
  };

  home.file.".ssh/sockets/.keep".text = "# Managed by Home Manager";
}
