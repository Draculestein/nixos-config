{ config, pkgs, lib, sops-nix, config-secrets, ... }:
let 
  secretsDir = builtins.toString config-secrets;
  secretsPath = "${secretsDir}/secrets.yaml";
in 
{
  imports = [
    sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${secretsPath}";
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;

    age.keyFile = "/home/albertjul/.config/sops/age/keys.txt";

    secrets = {
      "restic/environment" = { };
      "restic/repository" = { };
      "restic/password" = { };
    };
  };
}
