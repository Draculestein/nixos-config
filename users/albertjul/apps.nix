{ config, lib, pkgs, ... }:
{
  imports = [
    ../modules/gh.nix
    ../modules/foot.nix
    ../modules/bash.nix
    ../modules/zsh
    ../modules/brave.nix
    ../modules/starship
    ../modules/ssh.nix
    ../modules/direnv.nix
    ../modules/lutris.nix
    ../modules/devenv.nix
    ../modules/fastfetch.nix
    ../modules/fzf.nix
    ../modules/ghostty.nix
    ../modules/vscode.nix
    ../modules/distrobox.nix
    ../modules/niri
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    papirus-icon-theme
    thunderbird
    # zoom-us
    vesktop
    rnote
    gnome-disk-utility
    # supergfxctl-plasmoid
    nautilus
    sushi
    image-roll
    vlc
    firefox
    onlyoffice-bin
    libreoffice
    kdePackages.okular
    desktop-file-utils
    gnome-tweaks
    nixpkgs-fmt
    nixd
    path-of-building
    bitwarden-desktop
    # mysql-workbench
    gnome-software
    gnome-font-viewer
    gnome-disk-utility
    gnomeExtensions.system-monitor
    baobab
    file-roller
    seahorse
    d-spy
    obsidian
    google-chrome
    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
        pkgs.gamemode
      ];
    })
    libinklevel
  ];

  programs.zed-editor.enable = true;

}
