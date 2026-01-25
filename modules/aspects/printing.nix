{ den, ... }:
{
  den.aspects.printing = {
    nixos = { config, lib, pkgs, ... }: {
      services.printing = {
        enable = true;
        drivers = with pkgs; [
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
          pkgs.epsonscan2
        ];
      };
    };
  };
}
