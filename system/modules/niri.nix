{ config, pkgs, lib, inputs, ... }: {

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri.enable = true;
  # programs.niri.package = pkgs.niri-unstable;

}
