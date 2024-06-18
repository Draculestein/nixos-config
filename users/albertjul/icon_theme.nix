{ config, pkgs, ... }:

{
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
