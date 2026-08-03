{ den, inputs, ... }:
{
  flake-file.inputs.nix-amd-ai.url = "github:noamsto/nix-amd-ai";

  den.aspects.amd-npu = {
    nixos = { lib, ... }: {
      imports = [ inputs.nix-amd-ai.nixosModules.default ];

      hardware.amd-npu = {
        enable = true;
        enableLemonade = lib.mkDefault false;
        enableFastFlowLM = lib.mkDefault false;
        enableROCm = lib.mkDefault false; # ROCm GPU backends (llamacpp + sd-cpp)
        enableVulkan = lib.mkDefault false; # Vulkan GPU backends (llamacpp + whispercpp)
        enableImageGen = lib.mkDefault false;
      };

    };
  };
}
