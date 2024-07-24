{ config, pkgs, ... }:
let
  username = config.users.users.albertjul.name;
  userId = config.users.users.albertjul.uid;
  secretsPath = "/run/secrets/restic";
  backupName = "albertjul-FlowX13-B2backup";
  serviceName = "restic-backups-${backupName}";
in
{
  environment.systemPackages = with pkgs; [
    restic
    libnotify
  ];

  services.restic.backups.${backupName} = {
    initialize = true;
    user = "${username}";
    environmentFile = "${secretsPath}/environment";
    repositoryFile = "${secretsPath}/repository";
    passwordFile = "${secretsPath}/password";

    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 12"
      "--keep-yearly 2"
    ];

    paths = [
      "/home/${username}"
    ];

    exclude = [
      "/home/${username}/.cache"
      "/home/${username}/.local/share/Trash"
      "/home/${username}/.var/app/*/cache"
      "/home/${username}/.local/share/containers/"
    ];

    extraBackupArgs = [
      "--exclude-caches"
      "--verbose=2"
    ];

    # Necessary to prevent locks from persisting indefinitely. See more:
    # https://forum.restic.net/t/restic-unlock-automation/5511
    backupPrepareCommand = "${pkgs.restic}/bin/restic unlock";

    timerConfig = {
      OnCalendar = "15:00";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };

  # Got the script from Arthur Koziel (see https://www.arthurkoziel.com/restic-backups-b2-nixos/)
  systemd.services.${serviceName}.unitConfig.OnFailure = "notify-backup-failed.service";

  systemd.services."notify-backup-failed" = {
    enable = true;
    description = "Notify on failed backup";
    serviceConfig = {
      Type = "oneshot";
      User = username;
    };

    script = ''
      sudo -u ${username} \
      DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/${toString userId}/bus \
      ${pkgs.libnotify}/bin/notify-send \
      --urgency=critical --icon=dialog-error --app-name="Restic Backup albertjul" \
      "Backup failed" \
      "$(journalctl -u ${serviceName} -n 5 -o cat)"
    '';
  };

}
