{ den, inputs, ... }:
{
  den.aspects.AlbertProP16.nixos = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
      inputs.nixos-hardware.nixosModules.common-cpu-amd
      inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      inputs.nixos-hardware.nixosModules.common-pc-laptop
      inputs.ucodenix.nixosModules.default
    ];

    # Use the systemd-boot EFI boot loader.
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      loader.timeout = 0;
      kernelPackages = pkgs.linuxPackages_6_18;
      supportedFilesystems.ntfs = true;

      blacklistedKernelModules = [ "ucsi_acpi" ];
      initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
      initrd.kernelModules = [ "dm-snapshot" ];
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };

    networking.useDHCP = true;

    nixpkgs.config.allowUnfree = true;

    hardware.enableRedistributableFirmware = true;
    hardware.enableAllFirmware = true;
    hardware.sensor.iio.enable = true;

    hardware.bluetooth = {
      enable = true;
    };
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    services.ucodenix = {
      enable = true;
      cpuModelId = "00B20F40";
    };

    networking.hostName = "AlbertProP16";
    networking.networkmanager = {
      enable = true;
    };

    networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

    time.timeZone = lib.mkDefault "America/Denver";
    services.automatic-timezoned.enable = true;

    services.geoclue2 = {
      enable = true;
      enableDemoAgent = lib.mkForce true;
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "C.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
    ];

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Configure keymap in X11
    services.xserver.xkb.layout = "us";

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

    environment.shells = with pkgs; [
      zsh
      bash
    ];

    programs.zsh.enable = true;
    programs.dconf.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

  };
}
