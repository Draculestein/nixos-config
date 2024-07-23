{ config, lib, pkgs, ... }:
{
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
  };

  home.extraOptions = {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus Icon Theme";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
