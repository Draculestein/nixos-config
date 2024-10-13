{ config, lib, pkgs, inputs, ... }:
{

  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = true;
    image = ./desktop.jpg;

    polarity = "dark";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    cursor = {
      name = "Vimix-Cursors";
      package = pkgs.vimix-cursor-theme;
      size = 12;
    };

    fonts = { 
      monospace = {
        name = "Hasklig";
        package = pkgs.hasklig;
      };

      serif = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
      };

      sansSerif = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };

    targets = {
      vscode.enable = true;
      hyprpaper.enable = true;
      rofi.enable = false;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  # home.pointerCursor = {
  #    gtk.enable = true;
  #    package = pkgs.vimix-cursor-theme;
  #    name = "Vimix-Cursors";
  #    size = 12;
  # };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "adwaita";
  #   style.name = "adwaita-dark";
  # };

  # gtk = {
  #   enable = true;
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
