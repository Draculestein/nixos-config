{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    sddm-sugar-dark 
    libsForQt5.qt5.qtgraphicaleffects
  ];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sugar-dark";
  };
}
