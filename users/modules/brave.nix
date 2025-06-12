{ config, pkgs, ... }:

{
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--password-store=detect"
      "--enable-features=AcceleratedVideoEncoder,AcceleratedVideoDecodeLinuxZeroCopyGL,VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,TouchpadOverscrollHistoryNavigation"
      "--ozone-platform-hint=auto"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
    ];
  };
}
