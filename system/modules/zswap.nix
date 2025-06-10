{ config, pkgs, ... }:
{
  # Enable zswap with lz4
  boot.kernelModules = [ "lz4" ];
  boot.kernelParams = [
    "zswap.enabled=1"
  ];
  
  systemd.services.zswap-configure = {
    description = "Configure zswap";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      echo lz4 > /sys/module/zswap/parameters/compressor
    '';
  };

}
