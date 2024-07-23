{ config, lib, pkgs, disko, ... }:
{
  import = [
    disko.nixosModules.default
    (import ./disk_config.nix { device = "/dev/nvme0n1"; })

  ];
}
