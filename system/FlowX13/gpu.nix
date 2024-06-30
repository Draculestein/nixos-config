{ config, lib, pkgs, ... }:

{

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    nvidiaSettings = true;

    powerManagement.enable = true;
    powerManagement.finegrained = true;

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
