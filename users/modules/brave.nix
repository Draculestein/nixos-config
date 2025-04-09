{ config, pkgs, ... }:

{
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--password-store=detect"
      "--enable-features=AcceleratedVideoDecodeLinuxGL,VaapiVideoDecoder,TouchpadOverscrollHistoryNavigation"
      "--ozone-platform-hint=auto"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
    ];
  };
}
