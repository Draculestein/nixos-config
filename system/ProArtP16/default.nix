{ config, lib, pkgs, ... } : {
  imports = [

    ./configuration.nix

    # Hardware
    ../modules/zswap.nix
    ./gpu.nix
    ./disk.nix
    ../modules/asus.nix
    # ../modules/wacom.nix
    ../modules/xboxController.nix
    ../modules/autocpu-freq.nix
    # ../modules/powerprofilesdaemon.nix
    ../modules/blueman.nix

    # Display Manager and DE
    ../modules/gdm.nix
    ../modules/gnome.nix
    ../modules/niri.nix
    # ../modules/sddm.nix

    # Software
    ../modules/fonts.nix
    ./packages.nix
    ../modules/printing.nix
    ../modules/logitech.nix
    ../modules/nh.nix
    ../modules/nixSettings.nix
    ../modules/virtualization.nix
    ../modules/restic.nix
    ../modules/sops.nix
    ../modules/sound.nix
    ../modules/steam.nix
    ../modules/flatpak.nix
    ../modules/ssh.nix
    # ../modules/zoom-us.nix
    ../modules/stylix
  ];

  # environment.systemPackages = with pkgs; [ 
  #   sddm-sugar-dark 
  #   libsForQt5.qt5.qtgraphicaleffects
  # ];

  # services.displayManager.sddm.theme = "sugar-dark";
}
