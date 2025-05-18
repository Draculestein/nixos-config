{ config, lib, pkgs, inputs, ... }: {
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
