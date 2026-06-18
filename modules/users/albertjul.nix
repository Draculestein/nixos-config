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
        winboat
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
        # Use Kvantum as the Qt style (sets QT_STYLE_OVERRIDE=kvantum). KDE apps
        # such as Okular ignore the qt5ct/qt6ct custom Fusion palette but DO honor
        # the active Kvantum theme, so Kvantum is what actually themes them.
        # The "Noctalia" Kvantum theme is regenerated from the live Noctalia
        # palette on every theme change (see the noctalia user template in
        # aspects/desktop/niri/default.nix and the files provisioned below).
        style.name = "kvantum";

        # qt5ct/qt6ct still own fonts + icon theme. The style is left as kvantum
        # to match QT_STYLE_OVERRIDE; the colour scheme comes from Kvantum, not a
        # qtct custom palette.
        qt5ctSettings = {
          Appearance = {
            style = "kvantum";
            icon_theme = "Papirus-Dark";
            standard_dialogs = "default";
          };
          Fonts = {
            general = ''"Adwaita Sans,10"'';
            fixed = ''"Hasklig,10"'';
          };
        };
        qt6ctSettings = {
          Appearance = {
            style = "kvantum";
            icon_theme = "Papirus-Dark";
            standard_dialogs = "default";
          };
          Fonts = {
            general = ''"Adwaita Sans,10"'';
            fixed = ''"Hasklig,10"'';
          };
        };
      };

      # Kvantum theme "Noctalia": static pieces provisioned here, colours
      # regenerated by the noctalia user template (see niri/default.nix).
      xdg.configFile = {
        # Select the generated theme as the active Kvantum theme.
        "Kvantum/kvantum.kvconfig".text = ''
          [General]
          theme=Noctalia
        '';

        # Widget shapes (frames, gradients, scrollbars, ...) are inherited from
        # KvArcDark's SVG. Only the colours are overridden by the rendered
        # kvconfig, so we reuse KvArcDark's artwork verbatim.
        "Kvantum/Noctalia/Noctalia.svg".source =
          "${pkgs.libsForQt5.qtstyleplugin-kvantum}/share/Kvantum/KvArcDark/KvArcDark.svg";

        # Template consumed by noctalia. It rewrites
        # ~/.config/Kvantum/Noctalia/Noctalia.kvconfig with the live palette.
        "noctalia/templates/Noctalia.kvconfig".source = ./kvantum-noctalia.kvconfig;
      };
    };
  };
}
