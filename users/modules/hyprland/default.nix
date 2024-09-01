{ config, pkgs, lib, inputs, ... }:
{
  windows.windowsManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;

    settings = {
      # ======== Environment ========
      env = [
        "GDK_BACKEND, wayland,x11,*"
        "QT_QPA_PLATFORM, wayland;xcb"
        "SDL_VIDEODRIVER, wayland"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "XCURSOR_SIZE, 24"
        "HYPRCURSOR_SIZE, 24"
      ];

      # ======== Autostart ========
      exec-once = [
        "ags"
      ];

      # ======== Monitor ========
      monitor = [
        "eDP-1, 1920x1200@60, 0x0, 1"
        "DP-1, 1920x1080@164.92, -1920x01"
      ];

      # ======== Binds ========
      "$mod" = "SUPER";
      "$terminal" = "foot";
      "$fileManager" = "nautilus";
      "$browser" = "brave";

      bind = [
        "$mod, B, exec, $browser"
        "$mod, T, exec, $terminal"
        "$mod, E, exec, $fileManager"
        "$mod, Q, killactive"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];
    };
  };
}
