# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix   
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "AlbertFlowX13"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable KDE Plasma
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;


  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

    users.users.albertjul = {
     isNormalUser = true;
     uid = 1000;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       firefox
       brave
     ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     tree
     btop
    ];

    environment.shells = with pkgs; [ zsh ];
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    fonts.packages = with pkgs; [
      nerdfonts
      corefonts
      vistafonts
    ];
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

