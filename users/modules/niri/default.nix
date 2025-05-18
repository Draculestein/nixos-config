{ config, lib, pkgs, inputs, ... }: {

  home.packages = [ pkgs.xwayland-satellite-unstable ];

  programs.swaylock.enable = true;

  # programs.niri.enable = true;

  # programs.niri.settings =
  #   with config.lib.niri.actions;
  #   {
  #     binds = {
  #       "Mod+Shift+Slash".action = show-hotkey-overlay;
  #     };
  #   };
}
