{ config, pkgs, ... }:
{

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      amdvlk
      nvidia-vaapi-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      amdvlk
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    nvidiaSettings = true;

    powerManagement.enable = true;
    powerManagement.finegrained = true;
    dynamicBoost.enable = true;

    open = true;

    prime = {
      amdgpuBusId = "PCI:65:0:0";
      nvidiaBusId = "PCI:64:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  boot.kernelParams = [ "mem_sleep_default=deep" ];
}
