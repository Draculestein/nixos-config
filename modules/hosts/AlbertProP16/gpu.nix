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

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
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

    # amdgpu PSR-SU (Panel Self Refresh) on Strix Point / DCN 3.5 freezes the
    # internal eDP-1 panel (screen sticks on a stale frame; niri logs
    # "missing surface in vblank callback"). 0x10 = DC_DISABLE_PSR.
    boot.kernelParams = [ "nvidia.NVreg_TemporaryFilePath=/var/tmp" "amdgpu.dcdebugmask=0x10" ];
    services.udev.extraRules = ''
      KERNEL=="card*", \
      KERNELS=="0000:66:00.0", \
      SUBSYSTEM=="drm", \
      SUBSYSTEMS=="pci", \
      SYMLINK+="dri/amd-igpu"
    '';

  };
}
