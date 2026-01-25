{ den, ... }:
{
  den.aspects.stylix = {
    nixos = { inputs, pkgs, ... }: {
      imports = [ inputs.stylix.nixosModules.stylix ];

      stylix = {
        enable = true;
        autoEnable = false;
        image = ./default_wp.png;
        polarity = "dark";

        homeManagerIntegration.followSystem = false;
      };
    };

    homeManager = { pkgs, ... }: {
      stylix = {
        enable = true;
        image = ./desktop.jpg;

        polarity = "dark";

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
            name = "Adwaita Sans";
            package = pkgs.adwaita-fonts;
          };

          sansSerif = {
            name = "Adwaita Sans";
            package = pkgs.adwaita-fonts;
          };

          sizes = {
            applications = 10;
            desktop = 10;
            popups = 10;
            terminal = 12;
          };
        };

        icons = {
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
    };
  };
}
