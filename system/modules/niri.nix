{ config, lib, pkgs, inputs, ... }: {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  security.pam.services.swaylock = { };
}

