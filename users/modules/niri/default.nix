{ config, lib, pkgs, inputs, ... }: {

  imports = [
    ./xwayland.nix
    ./binds.nix
    ./settings.nix
    ./window-rules.nix
  ];

  services.swww.enable = true;
  services.mako.enable = true;
  programs.swaylock.enable = true;
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
}
