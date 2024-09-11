{ config, pkgs, lib, ... }:
{
  systemd.user.services = {
    start-polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "Run GNOME's Polkit";
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 3;
        TimeoutStopSec = 10;
      };
    };

    start-gnome-keyring-daemon = {
      Unit = {
        Description = "Start GNOME Keyring daemon on startup";
      };

      Service = {
        Type = "exec";
        ExecStart = "gnome-keyring-daemon -r -d";
        Restart = "on-failure";
        RestartSec = 3;
        Environment = [
          "SSH_AUTH_SOCK=%t/ssh-agent.socket"
          "DISPLAY=:0"
        ];
      };
    };
  };

}
