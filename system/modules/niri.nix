{ config, lib, pkgs, inputs, ... }: {
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };
  systemd.user.services.xwayland-satellite.wantedBy = [ "graphical-session.target" ];
  security.pam.services.swaylock = { };
}

