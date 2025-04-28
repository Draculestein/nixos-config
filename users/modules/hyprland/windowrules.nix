{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # ======== Windowrules ========
    windowrulev2 = [
      "suppressevent maximize, class:.*" # You'll probably like this.
      "float, class:(xdg-desktop-portal-)(.*)"
      "plugin:hyprbars:nobar, class:(xdg-desktop-portal-)(.*)"

      "float, class:(org.gnome.NautilusPreviewer)"
      "plugin:hyprbrars:nobar, class:(org.gnome.NautilusPreviewer)"
      "float, class:(flameshot)"
      "float, class:(clipse)"
      "size 622 652, class:(clipse)"

      "plugin:hyprbars:nobar, class:(brave-browser)"
      "plugin:hyprbars:nobar, class:(thunderbird)"
      "plugin:hyprbars:nobar, class:(org.gnome.Nautilus)"
      "plugin:hyprbars:nobar, class:(url-code-handler)"

    ];
  };
}
