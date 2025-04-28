{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # ======== Autostart ========
    exec-once = [
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment PATH"
      "systemctl --user restart xdg-desktop-portal-gtk &"
      "systemctl --user restart xdg-desktop-portal-hyprland "
      "systemctl --user restart xdg-desktop-portal &"
      "hypridle"
      "hyprpaper"
      "iio-hyprland"
      "systemctl start --user my-polkit-gnome-authentication-agent-1"
      "systemctl start --user start-gnome-keyring-daemon"
      "clipse -listen"
      "swaync"
      "swayosd-server"
      "waybar"
      # "$HOME/.nix-profile/bin/eww daemon"
    ];
  };
}
