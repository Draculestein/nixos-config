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
        ExecStart = "/run/wrappers/bin/gnome-keyring-daemon -s";
        Environment = [
          "SSH_AUTH_SOCK=%t/keyring/ssh"
          "DISPLAY=:0"
        ];
      };
    };
  };

}
