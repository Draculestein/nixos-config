{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      # ======== Autostart ========
      exec-once = [
        "hyprpaper &"
        "systemctl start --user my-polkit-gnome-authentication-agent-1 &"
        "systemctl start --user start-gnome-keyring-daemon &"
        "ags"
      ];
    };
  };
}
