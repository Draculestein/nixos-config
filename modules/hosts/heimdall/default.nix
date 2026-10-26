{ den, inputs, ... }:
{
  den.aspects.heimdall = {
    includes = [
      den._.hostname
      den.aspects.openssh-server
      den.aspects.opnsense
    ];

    nixos =
      {
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }:
      {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-pc-ssd
        ];

        boot = {
          loader.systemd-boot.enable = true;
          loader.efi.canTouchEfiVariables = true;

          initrd.availableKernelModules = [
            "xhci_pci"
            "ahci"
            "nvme"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
          initrd.kernelModules = [ ];
          kernelModules = [ "kvm-intel" ];
          extraModulePackages = [ ];
          # Nixpkgs' default follows the stable LTS kernel, not linuxPackages_latest.
          kernelPackages = pkgs.linuxPackages;
          zfs.forceImportRoot = false;
        };

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

        hardware.enableRedistributableFirmware = true;
        # Stable, unique ZFS identity; keep this across reinstalls.
        networking.hostId = "8425e349";
        services.zfs.autoScrub.enable = true;
        networking.networkmanager.enable = true;
      };
  };
}
