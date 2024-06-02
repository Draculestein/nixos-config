{ config, lib, pkgs, ... }:

{
    # Enable OpenGL.
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      nvidiaSettings = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;

      prime = {
	      amdgpuBusId = "PCI:8:0:0";
        nvidiaBusId = "PCI:1:0:0";

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };

      # nvidia-container-toolkit.enable = true;
    };
}
