{ config, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./theme.nix
    ./files.nix
    ./fonts.nix
    ./variables.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "albertjul";
  home.homeDirectory = "/home/albertjul";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
