{ den, inputs, ... }:
{
  flake-file.inputs.nix-amd-ai.url = "github:noamsto/nix-amd-ai";

  den.aspects.ai.lemonade = {
    nixos = {
      imports = [ inputs.nix-amd-ai.nixosModules.default ];

      hardware.amd-npu = {
        enable = true;
        enableFastFlowLM = true; # LLM inference on NPU
        enableLemonade = true; # OpenAI-compatible API server
        enableROCm = true; # ROCm GPU backends (llamacpp + sd-cpp)
        enableVulkan = true; # Vulkan GPU backends (llamacpp + whispercpp)
        enableImageGen = true; # default true; set false to drop sd-cpp from closure
        lemonade.user = "albertjul";
      };

      users.users.albertjul.extraGroups = [ "video" "render" ];
    };
  };
}
