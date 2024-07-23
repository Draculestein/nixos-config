{ config, pkgs, lib, ... }:

{
  sops = {
    defaultSopsFile = "/home/albertjul/.secrets/secrets.yaml";
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;

    age.keyFile = "/home/albertjul/.config/sops/age/keys.txt";

    secrets = {
      "restic/environment" = {};
      "restic/repository" = {};
      "restic/password" = {};
    };
  };
}