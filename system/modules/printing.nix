{ config, lib, pkgs, inputs, ... }:
let
  pkgsEpson = import inputs.nixpkgs-epson-fix {
    system = "x86_64-linux";
  };
in
{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs;[
      epson-escpr2
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgsEpson.epsonscan2
    ];
  };
}
