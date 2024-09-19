{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # ======== Autostart ========
    exec-once = [
      "systemctl --user import-environment PATH &"
      "hypridle &"
      "hyprpaper &"
      "iio-hyprland &"
      "systemctl start --user my-polkit-gnome-authentication-agent-1 &"
      "systemctl start --user start-gnome-keyring-daemon &"
      "ags"
    ];
  };
}
