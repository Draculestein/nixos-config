{ config, modulesPath, lib, pkgs, ... } : {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"

    ./configuration.nix

    # Hardware
    ../modules/zswap.nix
    ./gpu.nix
    ./disk.nix
    ../modules/asus.nix
    ../modules/wacom.nix
    ../modules/xboxController.nix
    ../modules/tlp.nix
    ../modules/blueman.nix

    # Display Manager and DE
    ../modules/sddm.nix
    ../modules/plasma6.nix

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
    ../modules/stylix
  ];
}