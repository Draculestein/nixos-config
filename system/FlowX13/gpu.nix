{ config, lib, pkgs, ... }:

{
    # Enable OpenGL.
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # services.xserver.videoDrivers = [ "nvidia" ];
    # hardware.nvidia = {
    #   modesetting.enable = true;
    #   nvidiaSettings = true;
    # };
}