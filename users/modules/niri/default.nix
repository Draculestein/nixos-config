{ config, lib, pkgs, inputs, ... }: {

  imports = [
    ./xwayland.nix
  ];

  services.swww.enable = true;
  services.mako.enable = true;
  programs.swaylock.enable = true;
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
  
  # Commented due to missing niri module
  # programs.niri.settings =
  #   {
  #     binds = with config.lib.niri.actions;{
  #       "Mod+Shift+Slash".action = show-hotkey-overlay;
  #     };
  #   };
}
