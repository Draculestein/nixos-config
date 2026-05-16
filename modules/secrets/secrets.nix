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

  # Infrastructure-only aspect: wires up sops-nix and points it at the
  # encrypted secrets file. Services/aspects that need individual secrets
  # should `include` this aspect and declare their own `sops.secrets.*`
  # entries (see e.g. system/restic.nix).
  den.aspects.secrets.nixos = { pkgs, ... }: {
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
    };
  };
}
