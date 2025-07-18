{ config, lib, pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ./desktop.jpg;

    polarity = "dark";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    cursor = {
     name = "Capitaine Cursors (Palenight)";
     package = pkgs.capitaine-cursors-themed;
     size = 16;
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

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus";
      light = "Papirus-Light";
    };

    targets = {
      vscode.enable = false;
      hyprpaper.enable = true;
      rofi.enable = false;
      waybar.enable = false;
      spicetify.enable = false;
      kitty.enable = false;

    };
  };

  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     name = "Papirus";
  #     package = pkgs.papirus-icon-theme;
  #   };
  # };

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
