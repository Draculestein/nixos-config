{ config, lib, pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    helvetica-neue-lt-std
    roboto
    cantarell-fonts
    source-code-pro
    source-sans
    hasklig
  ];

}
