{ config, lib, pkgs, ... }:
let
  epsonScan = pkgs.epsonscan2.override
    {
      withNonFreePlugins = true;
      withGui = true;
    };
in
{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs;[
      epson-escpr
      epsonscan2
    ] ++ [ epsonScan ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [
      epsonScan
    ];
  };
}
