{ config, lib, pkgs, ... }:
{
  imports = [
    ../modules/foot.nix
    ../modules/bash.nix
    ../modules/zsh
    ../modules/brave.nix
    ../modules/starship
    ../modules/ssh.nix
    ../modules/direnv.nix
    ../modules/lutris.nix
    ../modules/ags.nix
    ../modules/fastfetch.nix
    ../modules/hyprland
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    vscode
    gh
    papirus-icon-theme
    thunderbird
    zoom-us
    vesktop
    rnote
    gnome-disk-utility
    # supergfxctl-plasmoid
    nautilus
    sushi
    devenv
    vlc
    firefox
    onlyoffice-bin
    kdePackages.okular
    desktop-file-utils
    gnome-tweaks
    nil
    nixpkgs-fmt
    nixd
    path-of-building
    bitwarden-desktop
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

}
