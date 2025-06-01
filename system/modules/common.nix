{ config, lib, pkgs, ... }: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.shells = with pkgs; [
    zsh
    bash
  ];

  environmnent.systemPackages = with pkgs; [
    killall
  ];

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  services.gvfs.enable = true;
  services.gnome.localsearch.enable = true;
}
