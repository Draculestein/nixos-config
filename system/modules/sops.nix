{ config, pkgs, lib, sops-nix, config-secrets, ... }:
let
  secretsDir = builtins.toString config-secrets;
  secretsPath = "${secretsDir}/secrets.yaml";
in
{
  imports = [
    sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];

  sops = {
    defaultSopsFile = "${secretsPath}";
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;

    age.keyFile = "/home/albertjul/.config/sops/age/keys.txt";

    secrets = {
      "restic/environment" = {
        owner = config.users.users.albertjul.name;
      };
      "restic/repository" = {
        owner = config.users.users.albertjul.name;
      };
      "restic/password" = {
        owner = config.users.users.albertjul.name;
      };
    };
  };
}
