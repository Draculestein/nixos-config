{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ sddm-sugar-dark ];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sugar-dark";
  };
}
