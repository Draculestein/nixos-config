{ config, lib, pkgs, inputs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [
        "/home/albertjul/Pictures/Saved Pictures/desktop.png"
      ];

      wallpaper = [
        ", /home/albertjul/Pictures/Saved Pictures/desktop.png"
      ];
    };
  };
}
