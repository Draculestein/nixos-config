{ den, ... }:
{
  den.aspects.logitech = {
    nixos = { config, lib, pkgs, ... }: {
      hardware.logitech.wireless.enable = true;
      programs.solaar.enable = true;

      services.ratbagd.enable = true;
      environment.systemPackages = [ pkgs.piper ];
    };
  };
}
