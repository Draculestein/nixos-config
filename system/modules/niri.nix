{ config, lib, pkgs, inputs, ... }: {
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.package = pkgs.niri-unstable;
}

