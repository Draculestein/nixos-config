{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = false;
    image = ./desktop.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    cursor = {
      package = pkgs.vimix-cursor-theme;
      name = "Vimix-Cursors";
      size = 12;
    };

    fonts = {
      monospace = {
        name = "Hasklug Nerd Font";
        package = pkgs.nerdfonts.override { fonts = [ "Hasklig" ]; };
      };
    };

    targets = {
      vscode.enable = false;
    };
  };

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
