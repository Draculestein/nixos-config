{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.default
    (import ./disk_config.nix { device = "/dev/nvme0n1"; })

  ];
}
