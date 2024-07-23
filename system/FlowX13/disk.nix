{ config, lib, pkgs, disko, ... }:
{
  imports = [
    disko.nixosModules.default
    (import ./disk_config.nix { device = "/dev/nvme0n1"; })

  ];
}
