{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = true;
    image = ./desktop.png;
    polarity = "dark";

    cursor = {
      package = pkgs.vimix-cursor-theme;
      name = "Vimix-Cursors";
      size = 12;
    };

    targets = {
      hyprland.enable = true;
      hyprpaper.enable = true;
    };
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "adwaita";
  #   style.name = "adwaita-dark";
  # };

  # gtk = {
  #   enable = true;
  #   gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  #   theme = {
  #     package = pkgs.gnome-themes-extra;
  #     name = "Adwaita-dark";
  #   };

  #   iconTheme = {
  #     name = "Papirus";
  #     package = pkgs.papirus-icon-theme;
  #   };
  # };


}
