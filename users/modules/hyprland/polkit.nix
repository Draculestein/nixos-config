{ config, pkgs, lib, ... }:
{
  systemd.user.services = {
    my-polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "Run GNOME's Polkit";
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

}
