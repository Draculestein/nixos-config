{ config, lib, pkgs, inputs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };

  # systemd.user.services.hyprpaper = {
  #   Unit = {
  #     ConditionEnvironment = lib.mkForce [ "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP=Hyprland" ];
  #   };
  # };
}
