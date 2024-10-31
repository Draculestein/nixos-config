{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland .settings = {
    # ======== Environment ========
    env = [
      "GDK_BACKEND,wayland,x11,*"
      "QT_QPA_PLATFORM,wayland;xcb"
      "SDL_VIDEODRIVER,wayland"
      "CLUTTER_BACKEND,wayland"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "XCURSOR_SIZE,24"
      "SSH_AUTH_SOCK,$XDG_RUNTIME_DIR/keyring/ssh"
    ];
  };
}
