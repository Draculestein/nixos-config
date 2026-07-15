{ den, inputs, ... }:
{
  flake-file.inputs.nix-amd-ai.url = "github:noamsto/nix-amd-ai";

  den.aspects.amd-npu = {
    nixos = { lib, ... }: {
      imports = [ inputs.nix-amd-ai.nixosModules.default ];

      hardware.amd-npu = {
        enable = true;
        enableLemonade = lib.mkDefault false;
      };

    };
  };
}
