{ config, pkgs, lib, inputs, ... }:
{
  windows.windowsManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {



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
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];
    };
  };
}
