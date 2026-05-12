{ den, inputs, ... }:
{
  flake-file.inputs.nix-amd-ai.url = "github:noamsto/nix-amd-ai";

  den.aspects.ai.provides.lemonade = {
    nixos = {
      imports = [ inputs.nix-amd-ai.nixosModules.default ];

      hardware.amd-npu = {
        enable = true;
        enableFastFlowLM = true;
        enableLemonade = true;
        enableROCm = true;
        enableVulkan = true;
        enableImageGen = true;
        lemonade.user = "albertjul";
      };

      users.users.albertjul.extraGroups = [ "video" "render" ];
    };
  };
}
