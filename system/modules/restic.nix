{ config, pkgs, ... }:
let
  username = "albertjul";
  secretsPath = "/run/secrets/restic";
in
{
  services.restic.backups.albertjul-FlowX13-B2backup = {
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
    ];

    extraBackupArgs = [
      "--exclude-caches"
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

}
