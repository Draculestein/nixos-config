{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # ======== Windowrules ========
    windowrulev2 = [
      "suppressevent maximize, class:.*" # You'll probably like this.
      "float, class:(xdg-desktop-portal-)(.*)"
      "float, class:(org.gnome.NautilusPreviewer)"
      "float, class:(flameshot)"
      "float, class:(clipse)"
      "size 622 652, class:(clipse)"
    ];
  };
}