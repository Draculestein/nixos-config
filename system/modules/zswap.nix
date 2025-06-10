{config, pkgs, ...}:
{
  # Enable zswap with lz4
  boot.initrd.kernelModules = [ "lz4" ];
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=lz4"
  ];


}