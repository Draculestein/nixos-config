{ config, lib, pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    tree
    btop
    pciutils
    usbutils
    restic
    vulkan-tools
    nvtopPackages.full
    nix-output-monitor
    nvd
    sops
  ];
}
