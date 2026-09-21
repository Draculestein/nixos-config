{ den, inputs, ... }:
{
  den.aspects.heimdall = {
    includes = [
      den._.hostname
      den.aspects.openssh-server
      den.aspects.incus
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
        };

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

        hardware.enableRedistributableFirmware = true;
        networking.networkmanager.enable = true;
      };
  };
}
