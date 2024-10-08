{ config, pkgs, ... }:

{
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--password-store=detect"
      "--use-gl=angle"
      "--use-angle=vulkan"
      "--enable-features=TouchpadOverscrollHistoryNavigation,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,UseMultiPlaneFormatForHardwareVideo,VaapiVideoEncoder"
      "--ozone-platform=wayland"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
    ];
  };
}
