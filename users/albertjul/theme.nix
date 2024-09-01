{ config, lib, pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vimix-cursor-theme;
    name = "Vimix-Cursors";
    size = 12;
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}
