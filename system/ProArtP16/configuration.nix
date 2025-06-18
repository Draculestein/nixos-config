# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  boot.kernelPackages = pkgs.linuxPackages_6_15;
  boot.supportedFilesystems = {
    ntfs = true;
  };

  boot.blacklistedKernelModules = [ "ucsi_acpi" ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.sensor.iio.enable = true;

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking.hostName = "AlbertProP16";
  networking.networkmanager = {
    enable = true;
    wifi = {
      powersave = false;
    };
  };
  networking.wireless.enable = false;

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  networking.extraHosts = ''
    127.0.0.1 api.cyrano.localhost
    127.0.0.1 labs.localhost
    127.0.0.1 navapi.localhost
    127.0.0.1 internal.localhost
    127.0.0.1 admin.localhost
    127.0.0.1 app.cyrano.localhost
  '';

  # Set your time zone.
  time.timeZone = lib.mkDefault "America/Denver";
  services.automatic-timezoned.enable = true;

  services.geoclue2.enable = true;


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

  users.users.albertjul = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "podman" "gamemode" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ]; # Apps are handled by home-manager
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [
    zsh
    bash
  ];

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  services.gvfs.enable = true;
  services.gnome.localsearch.enable = true;

  services.udev.extraRules = ''
    ENV{DMI_FAMILY}=="*ProArt*", GOTO="asusd_start"
    GOTO="asusd_end"

    LABEL="asusd_start"
    ACTION=="add|change", DRIVER=="asus-nb-wmi", TAG+="systemd", ENV{SYSTEMD_WANTS}="asusd.service"

    LABEL="asusd_end"
  '';

  nix.settings = {
    substituters = [ "https://devenv.cachix.org" ];
    trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw= nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU=" ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

