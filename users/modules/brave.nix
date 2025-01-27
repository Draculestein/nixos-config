{ config, pkgs, ... }:

{
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--password-store=detect"
      "--enable-features=AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
      "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport"
      "--enable-features=UseMultiPlaneFormatForHardwareVideo,TouchpadOverscrollHistoryNavigation"
      "--ozone-platform=wayland"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
    ];
  };
}
