{ config, lib, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    cantarell-fonts
    nerd-fonts.hasklug
    nerd-fonts.fira-code
    corefonts
    vistafonts
    noto-fonts
    open-fonts
    noto-fonts-emoji
    noto-fonts-extra
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
