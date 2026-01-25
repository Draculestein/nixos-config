{ den, ... }:
{
  den.aspects.brave = {
    homeManager = { config, lib, pkgs, ... }: {
      programs.brave = {
        enable = true;
        package = pkgs.brave;

        commandLineArgs = [
          "--password-store=detect"
          "--enable-features=AcceleratedVideoEncoder,AcceleratedVideoDecodeLinuxZeroCopyGL,VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,TouchpadOverscrollHistoryNavigation"
          "--ozone-platform-hint=auto"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
        ];
      };
    };
  };
}
