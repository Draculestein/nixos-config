{ den, ... }: {
  den.aspects.albertjul = {
    includes = [
      # Development
      den.aspects.code-dev
      den.aspects.fzf
      den.aspects.ai.provides.amp-cli
      den.aspects.ai.provides.claude-code

      # Shell & Terminals
      den.aspects.zsh
      den.aspects.kitty

      # Apps
      den.aspects.brave
      den.aspects.spotify
      den.aspects.fastfetch
      den.aspects.distrobox
      den.aspects.ssh
      den.aspects.neovim

      # Desktop/WM
      den.aspects.niri
    ];

    nixos = { pkgs, ... }: {
      users.users.albertjul = {
        isNormalUser = true;
        uid = 1000;
        extraGroups = [ "wheel" "network" "podman" "gamemode" "libvirtd" "video" "dialout" "scanner" "lp" "disk" ];
        packages = [ ];
        shell = pkgs.zsh;
      };

      services.gvfs.enable = true;
      services.gnome.localsearch.enable = true;

      qt = {
        enable = true;
        platformTheme = "qt5ct";
        style = "kvantum";
      };
    };

    homeManager = { config, pkgs, lib, ... }: {
      home.username = "albertjul";
      home.homeDirectory = "/home/albertjul";
      home.stateVersion = "23.11";

      targets.genericLinux.enable = true;
      xdg.mime.enable = true;
      xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
      xdg.userDirs.enable = true;
      xdg.userDirs.templates = "$HOME/Templates";
      gtk.gtk4.theme = null;
      xdg.userDirs.setSessionVariables = true;

      programs.home-manager.enable = true;

      fonts.fontconfig.enable = true;
      fonts.fontconfig.defaultFonts = {
        monospace = [ "Hasklig" ];
        sansSerif = [ "Adwaita Sans" ];
        serif = [ "Adwaita Sans" ];
        emoji = [ "Noto Color Emoji" ];
      };

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
        # bitwarden-desktop
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
        awakened-poe-trade
      ];

      xdg.autostart = {
        enable = true;
        readOnly = false;
        entries = [
          "${pkgs.thunderbird}/share/applications/thunderbird.desktop"
        ];
      };

      services.mpris-proxy.enable = true; # Enable headset buttons for pause/play or to skip to the next track

      home.pointerCursor = {
        enable = true;
        name = "Capitaine Cursors (Palenight)";
        package = pkgs.capitaine-cursors-themed;
        size = 16;
        gtk.enable = true;
        x11.enable = true;
      };

      gtk = {
        enable = true;

        font = {
          name = "Adwaita Sans";
          package = pkgs.adwaita-fonts;
          size = 10;
        };

        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };

        cursorTheme = {
          name = "Capitaine Cursors (Palenight)";
          package = pkgs.capitaine-cursors-themed;
          size = 16;
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "qtct";
        # No QT_STYLE_OVERRIDE: let qt5ct/qt6ct pick the style (Fusion) so the
        # noctalia color scheme is actually applied. Kvantum would ignore it
        # since noctalia generates no Kvantum theme.
        style.name = "kvantum";

        # noctalia only writes ~/.config/qt{5,6}ct/colors/noctalia.conf but
        # never the main qt{5,6}ct.conf, so the palette is never selected.
        # These point qt5ct/qt6ct at that scheme + Fusion (which honors the
        # custom palette, unlike Kvantum). noctalia keeps re-rendering
        # colors/noctalia.conf on theme changes, so this stays dynamic.
        qt5ctSettings = {
          Appearance = {
            style = "Fusion";
            icon_theme = "Papirus-Dark";
            custom_palette = true;
            color_scheme_path = "${config.home.homeDirectory}/.config/qt5ct/colors/noctalia.conf";
            standard_dialogs = "default";
          };
          Fonts = {
            general = ''"Adwaita Sans,10"'';
            fixed = ''"Hasklig,10"'';
          };
        };
        qt6ctSettings = {
          Appearance = {
            style = "Fusion";
            icon_theme = "Papirus-Dark";
            custom_palette = true;
            color_scheme_path = "${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf";
            standard_dialogs = "default";
          };
          Fonts = {
            general = ''"Adwaita Sans,10"'';
            fixed = ''"Hasklig,10"'';
          };
        };
      };
    };
  };
}
