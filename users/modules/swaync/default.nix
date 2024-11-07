{ config, lib, pkgs, ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-layer = "top";
      control-center-margin-top = 2;
      control-center-margin-bottom = 2;
      control-center-margin-right = 1;
      control-center-margin-left = 0;
      control-center-width = 450;
      notification-2fa-action = true;
      notification-inline-replies = true;
      notification-icon-size = 32;
      notification-body-image-height = 140;
      notification-body-image-width = 180;
      notification-window-width = 350;
      fit-to-screen = true;

      timeout = 4;
      timeout-low = 2;
      timeout-critical = 0;

      widgets = [
        "title"
        "notifications"
        "mpris"
        "buttons-grid"
        "volume"
        "backlight"
      ];
      "widget-config" = {
        "title" = {
          "text" = "";
          "clear-all-button" = true;
          "button-text" = " Clear all ";
        };
        "dnd" = {
          "text" = " ";
        };
        "label" = {
          "max-lines" = 2;
          "text" = "Notification";
        };
        "mpris" = {
          "image-size" = 60;
          "image-radius" = 10;
        };
        "volume" = {
          "label" = "  󰕾";
          "show-per-app" = true;
        };
        "backlight" = {
          "label" = "  󰃟";
          "subsystem" = "backlight";
          "device" = "amdgpu_bl1";
        };

        "buttons-grid" = {
          "actions" = [
            {
              "label" = "  Wi-FI";
              "command" = "foot --app-id=nmtui nmtui";
            }
            {
              "label" = "󰕾 Mute";
              "command" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            }
            {
              "label" = "󰂯 Bluetooth";
              "command" = "blueman-manager";
            }
          ];
        };
      };
    };

    # CSS from Hyprcloud [https://github.com/arfan-on-clouds/hyprclouds/blob/main/config/swaync/style.css]
    style = ''
      @define-color color0 #${config.lib.stylix.colors.base00};
      @define-color color1 #${config.lib.stylix.colors.base01};
      @define-color color2 #${config.lib.stylix.colors.base02};
      @define-color color3 #${config.lib.stylix.colors.base03};
      @define-color color4 #${config.lib.stylix.colors.base04};
      @define-color color5 #${config.lib.stylix.colors.base05};
      @define-color color6 #${config.lib.stylix.colors.base06};
      @define-color color7 #${config.lib.stylix.colors.base07};
      @define-color color8 #${config.lib.stylix.colors.base08};
      @define-color color9 #${config.lib.stylix.colors.base09};
      @define-color color10 #${config.lib.stylix.colors.base0A};
      @define-color color11 #${config.lib.stylix.colors.base0B};
      @define-color color12 #${config.lib.stylix.colors.base0C};
      @define-color color13 #${config.lib.stylix.colors.base0D};
      @define-color color14 #${config.lib.stylix.colors.base0E};
      @define-color color15 #${config.lib.stylix.colors.base0F};

      @define-color background #${config.lib.stylix.colors.base00};
      @define-color foreground #${config.lib.stylix.colors.base07};
      @define-color noti-bg #${config.lib.stylix.colors.base02};
      @define-color noti-bg-hover #${config.lib.stylix.colors.base03};
      @define-color noti-border-color #${config.lib.stylix.colors.base01};
      @define-color mpris-album-art-overlay #${config.lib.stylix.colors.base0D};
    '' + builtins.readFile ./style.css;
  };
}
