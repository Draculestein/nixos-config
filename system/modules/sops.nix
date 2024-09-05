{ config, pkgs, lib, inputs, ... }:
let
  secretsDir = builtins.toString inputs.config-secrets;
  secretsPath = "${secretsDir}/secrets.yaml";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];

  sops = {
    defaultSopsFile = "${secretsPath}";
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;

    age.keyFile = "/var/lib/sops-nix/keys.txt";

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
