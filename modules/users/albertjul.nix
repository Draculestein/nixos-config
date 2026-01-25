{ den, ... }: {
  den.aspects.albertjul = {
    includes = [
      # Development
      den.aspects.code-dev
      den.aspects.gh
      den.aspects.direnv
      den.aspects.lazygit
      den.aspects.fzf

      # Shell & Terminals
      den.aspects.zsh
      den.aspects.kitty

      # Apps
      den.aspects.brave
      den.aspects.spotify
      den.aspects.fastfetch
      den.aspects.distrobox
      den.aspects.ssh

      # Desktop/WM
      den.aspects.niri
    ];

    nixos = { pkgs, ... }: {
      users.users.albertjul = {
        isNormalUser = true;
        uid = 1000;
        extraGroups = [ "wheel" "podman" "gamemode" "libvirtd" "video" "dialout" "scanner" "lp" ];
        packages = [ ];
        shell = pkgs.zsh;
      };

      services.gvfs.enable = true;
      services.gnome.localsearch.enable = true;
    };

    homeManager = { config, pkgs, ... }: {
      home.username = "albertjul";
      home.homeDirectory = "/home/albertjul";
      home.stateVersion = "23.11";

      targets.genericLinux.enable = true;
      xdg.mime.enable = true;
      xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

      programs.home-manager.enable = true;

      fonts.fontconfig.enable = true;

      home.packages = with pkgs; [
        # Fonts
        helvetica-neue-lt-std
        roboto
        cantarell-fonts
        source-code-pro
        source-sans
        hasklig
        corefonts
        vista-fonts
        inter
        adwaita-fonts

        # Apps
        papirus-icon-theme
        thunderbird
        vesktop
        rnote
        gnome-disk-utility
        bottles
        nautilus
        sushi
        image-roll
        vlc
        firefox
        onlyoffice-desktopeditors
        libreoffice
        kdePackages.okular
        desktop-file-utils
        gnome-tweaks
        nixpkgs-fmt
        nixd
        rusty-path-of-building
        bitwarden-desktop
        gnome-software
        gnome-font-viewer
        gnomeExtensions.system-monitor
        baobab
        file-roller
        seahorse
        d-spy
        obsidian
        google-chrome
        (heroic.override {
          extraPkgs = pkgs: [
            pkgs.gamescope
            pkgs.gamemode
          ];
        })
        libinklevel
        popsicle
        wf-recorder
        zotero
        slack
        zoom-us
      ];

      xdg.autostart = {
        enable = true;
        readOnly = false;
        entries = [
          "${pkgs.thunderbird}/share/applications/thunderbird.desktop"
        ];
      };

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
