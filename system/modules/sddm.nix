{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ catppuccin-sddm-corners ];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-sddm-corners";
  };
}
