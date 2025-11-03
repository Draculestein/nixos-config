{ config, lib, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    cantarell-fonts
    nerd-fonts.hasklug
    nerd-fonts.fira-code
    nerd-fonts.roboto-mono
    nerd-fonts.fira-mono
    nerd-fonts.noto
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.ubuntu-mono
    corefonts
    vista-fonts
    noto-fonts
    open-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    # textfonts
    freefont_ttf
    liberation_ttf
    lato
    carlito
  ];
}
