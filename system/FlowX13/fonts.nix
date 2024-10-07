{ config, lib, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    cantarell-fonts
    nerdfonts
    corefonts
    vistafonts
    noto-fonts
    open-fonts
    noto-fonts-emoji
    noto-fonts-extra
    noto-fonts-cjk
    noto-fonts-color-emoji
    # textfonts
    freefont_ttf
    liberation_ttf
    lato
    carlito
  ];
}
