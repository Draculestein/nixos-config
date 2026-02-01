{ den, inputs, ... }:
let
  secretsDir = builtins.toString inputs.config-secrets;
  secretsPath = "${secretsDir}/secrets.yaml";
in
{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake-file.inputs.config-secrets = {
    url = "git+ssh://git@github.com/Draculestein/nixos-secrets.git?ref=main&shallow=1";
    flake = false;
  };

  den.aspects.sops.nixos = { config, pkgs, ... }: {
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
  };
}
