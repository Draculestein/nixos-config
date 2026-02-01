{ den, ... }:
{
  den.aspects.AlbertProP16.nixos = { pkgs, config, ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };

    services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
    boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      nvidiaSettings = true;

      powerManagement.enable = true;
      powerManagement.finegrained = true;
      dynamicBoost.enable = true;

      open = true;

      prime = {
        amdgpuBusId = "PCI:66:0:0";
        nvidiaBusId = "PCI:65:0:0";

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };

    hardware.nvidia-container-toolkit.enable = true;

    # boot.kernelParams = [ "mem_sleep_default=deep" ];
    services.udev.extraRules = ''
      KERNEL=="card*", \
      KERNELS=="0000:66:00.0", \
      SUBSYSTEM=="drm", \
      SUBSYSTEMS=="pci", \
      SYMLINK+="dri/amd-igpu"
    '';

  };
}
