{ config, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    flake = "/home/albertjul/.dotfiles"
  };
  }
