{ config, lib, pkgs, ... } : {
  imports = [
    ./configuration.nix

    # Hardware
    ../modules/zswap.nix
    ./gpu.nix
    ./disk.nix
    ../modules/asus.nix
    ../modules/wacom.nix
    ../modules/xboxController.nix
    # ../modules/powertop.nix
    # ../modules/autocpu-freq.nix
    ../modules/tlp.nix
    ../modules/blueman.nix

    # Display Manager and DE
    ../modules/gdm.nix
    ../modules/gnome.nix
    # ../modules/sddm.nix
    # ../modules/plasma6.nix
    # ../modules/hyprland.nix
    ../modules/gnome-polkit.nix
    ../modules/niri.nix

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
    # ../modules/ollama.nix
  ];
}