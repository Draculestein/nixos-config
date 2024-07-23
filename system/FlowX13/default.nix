{ config, lib, pkgs, ... } : {
  imports = [
    ./configuration.nix

    # Hardware
    ./gpu.nix
    ./disk.nix
    ../modules/asus.nix
    ../modules/wacom.nix

    # Display Manager and DE
    ../modules/gdm.nix
    ../modules/gnome.nix

    # Software
    ../modules/printing.nix
    ../modules/logitech.nix
    ../modules/nh.nix
    ../modules/nixSettings.nix
    ../modules/podman.nix
    ../modules/restic.nix
    ../modules/sops.nix
    ../modules/sound.nix
    ../modules/steam.nix
    ../modules/flatpak.nix
  ];
}