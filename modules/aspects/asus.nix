{ den, ... }:
{
  den.aspects.asus.nixos = { lib, pkgs, ... }: {
    services.asusd = {
      enable = true;
    };

    services.supergfxd = {
      enable = true;
    };

    programs.rog-control-center = {
      enable = true;
    };

    systemd.user.services.rog-control-center = {
      description = "ASUS ROG Control Center";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${lib.getExe' pkgs.asusctl "rog-control-center"}";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };

    services.power-profiles-daemon.enable = lib.mkForce true;
  };
}
