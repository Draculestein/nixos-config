{ config, lib, pkgs, inputs, ... }:
{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    withUWSM = false;
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
    kitty
  ];

  programs.iio-hyprland.enable = true;

  security.polkit.enable = true;
  security.pam.services.hyprlock = { };

}
