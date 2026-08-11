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
      kernelPackages = pkgs.linuxPackages_7_1;
      supportedFilesystems.ntfs = true;

      blacklistedKernelModules = [ "ucsi_acpi" ];
      initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
      initrd.kernelModules = [ "dm-snapshot" ];
      kernelModules = [ "kvm-amd" "i2c-dev" "ddcci_backlight" ];
      extraModulePackages = with config.boot.kernelPackages; [ ddcci-driver ];
      kernelParams = [ "microcode.amd_sha_check=off" ];

    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
      "electron-40.10.5"
    ];

    hardware.enableRedistributableFirmware = true;
    hardware.enableAllFirmware = true;
    hardware.sensor.iio.enable = true;

    services.ddccontrol.enable = true;
    services.udev.extraRules = ''
      SUBSYSTEM=="i2c-dev", ACTION=="add", ATTR{name}=="NVIDIA i2c adapter*", TAG+="ddcci", TAG+="systemd", ENV{SYSTEMD_WANTS}+="ddcci@$kernel.service"
      SUBSYSTEM=="i2c-dev", ACTION=="add", ATTR{name}=="AMDGPU DM i2c hw bus*", TAG+="ddcci", TAG+="systemd", ENV{SYSTEMD_WANTS}+="ddcci@$kernel.service"
    '';

    systemd.services."ddcci@" = {
      scriptArgs = "%i";
      after = [ "graphical.target" ];
      script = ''
        echo "Trying to attach ddcci to $1"
        # amdgpu routes every connector's DDC over its "AMDGPU DM i2c hw bus N"
        # adapter (check: /sys/class/drm/card*-*/ddc -> that bus), NOT the
        # "AMDGPU DM aux" adapter, so we match the hw-i2c family by name (not
        # bus number, which renumbers across reboots). e.g. DP-3/VG278 is on
        # "AMDGPU DM i2c hw bus 2". The ddcci probe self-gates: it binds where
        # a monitor speaks DDC/CI and fails harmlessly (-ENODEV) elsewhere, so
        # matching all hw-i2c buses (incl. disconnected ports) is safe.
        echo "ddcci 0x37" > /sys/bus/i2c/devices/$1/new_device \
          && echo "Attached ddcci to $1" || echo "Failed to attach to $1"
      '';

      serviceConfig = {
        Type = "oneshot";
        Restart = "no";
      };
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

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
    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

    # time.timeZone = lib.mkDefault "America/Denver";
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

    environment.systemPackages = with pkgs; [
      vim
      wget
      git
      tree
      btop
      pciutils
      usbutils
      vulkan-tools
      nvtopPackages.full
      nix-output-monitor
      nvd
      libsForQt5.qtstyleplugin-kvantum
      clamav
      smartmontools
    ];

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = [ ];

  };
}
