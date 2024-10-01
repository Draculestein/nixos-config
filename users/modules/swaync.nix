{ config, lib, pkgs, ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      layer-shell = true;
      cssPriority = "application";
      control-center-layer = "top";
      control-center-margin-top = 2;
      control-center-margin-bottom = 2;
      control-center-margin-right = 1;
      control-center-margin-left = 0;
      control-center-width = 450;
      control-center-height = 1200;
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
          "text" = "󰂚       Notifications";
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
          "label" = "󰕾 ";
          "show-per-app" = true;
        };
        "backlight" = {
          "label" = "󰃟 ";
          "subsystem" = "backlight";
          "device" = "amdgpu_bl2";
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

      .testing {
          background-color: red;
        }

        .control-center {
          background: alpha(@background, 1);
          border-radius: 24px;
          border: 0px solid @foreground;
          margin: 2px;
          padding: 4px;
        }

        .control-center-list {
          background: transparent;
        }

        .control-center-list-placeholder {
          opacity: 0.8;
        }

        /* Window behind control center and on all other monitors */
        .blank-window {
          background: transparent;
        }

        /*** Widgets ***/

        /* Title widget */
        .widget-title {
          margin: 8px;
          font-size: 1.5rem;
          background: alpha(@color0,0.0);
        }
        .widget-title > button {
          font-size: initial;
          color:@color7;
          text-shadow: none;
          background: alpha(@background,0.0);
          border: 1px solid alpha(@color7,0.5);
          box-shadow: none;
          border-radius: 12px;
        }
        .widget-title > button:hover {
          background: @color1;
        }

        .widget-label {
          background: @color0;
          padding: 20px;
          padding-bottom: 50px;
          border-radius: 20px;
        }

        /* DND widget */
        .widget-dnd {
          background-color: @color0;
        }
        .widget-dnd > switch {
          font-size: initial;
          border-radius: 14px;
          background: @noti-bg;
          border: 2px solid @noti-border-color;
          box-shadow: none;
        }
        .widget-dnd > switch:checked {
          background: @color5;
        }
        .widget-dnd > switch slider {
          background: @noti-bg-hover;
          border-radius: 12px;
        }

        /* Label widget */
        .widget-label {
          margin: 8px;
        }
        .widget-label > label {
          font-size: 1.1rem;
        }

        /* Mpris widget */
        .widget-mpris {
          font-family: "JetBrains Mono Nerd Font";
          /* The parent to all players */
          border: 0px;
        }
        .widget-mpris-player {
          padding: 14px;
          margin: 14px;
          background-color: @mpris-album-art-overlay;
          border-radius: 20px;
        }
        .widget-mpris-album-art {
          border-radius: 12px;
        }
        .widget-mpris-player button:hover {
          /* The media player buttons (play, pause, next, etc...) */
          background: @noti-bg-hover;
        }
        .widget-mpris > box > button {
          /* Change player side buttons */
        }
        .widget-mpris > box > button:disabled {
          /* Change player side buttons insensitive */
        }
        .widget-mpris-title {
          font-family: "JetBrains Mono Nerd Font";
          font-weight: bold;
          font-size: 1.25rem;
        }
        .widget-mpris-subtitle {
          font-family: "JetBrains Mono Nerd Font";
          font-size: 1.1rem;
        }

        /* Buttons widget */
        .widget-buttons-grid {
          font-size: 15px;
          background: alpha(@background, 0.9);
          font-family: "JetBrains Mono Nerd Font";
          padding-left: 5px;
          margin-left: 10px;
          margin-right: 10px;
          border-radius: 20px;
          padding-top: 10px;
          padding-bottom: 10px;
          background-color: alpha(@background, 0.9);
        }

        .widget-buttons-grid > flowbox > flowboxchild > button {
          padding: 10px;
          background: @color1;
          color:@color7;
          border-radius: 20px;
          margin: 2px;
          border: 0px solid #04030a;
        }

        .widget-buttons-grid > flowbox > flowboxchild > button:hover {
          background: @color4;
          transition: all 0.3s ease-in-out;
        }

        /* Menubar widget */
        .widget-menubar > box > .menu-button-bar > button {
          border: none;
          background: transparent;
          background: red;
        }

        .topbar-buttons > button {
          /* Name defined in config after # */
          border: none;
          background: transparent;
          background: rgba(69, 133, 136, 1);
        }

        /* Volume widget */
        trough {
          border-radius: 20px;
          background: @background;
          border: 1px solid @background;
        }

        trough highlight {
          /* ´trough´ is the background of the slider, ´highlight´ is the actual slider */
          padding-top: 1px;
          background: @color4;
          border: 1px solid @color4;
          border-radius: 20px;
        }

        trough slider {
          padding: 1px;
          background: @color4;
          border: 1px solid @color4;
        }
        trough slider:hover {
          padding: 1px;
          background: @color4;
        }

        .widget-volume {
          background-color: alpha(@background, 0.0);
          border-radius: 20px 20px 0px 0px;
          font-size: 15px;
          margin-left: 10px;
          margin-right: 10px;
          padding-bottom: 5px;
          border: 0px solid transparent;
        }

        .widget-backlight {
          padding-left: 5px;
          background-color: alpha(@background, 0.0);
          font-size: 15px;
          margin-top: -8px;
          margin-left: 10px;
          margin-right: 10px;
          border-radius: 0px 0px 20px 20px;
          border: 0px solid transparent;
        }

        /* Title widget */
        .widget-inhibitors {
          margin: 8px;
          font-size: 1.5rem;
        }
        .widget-inhibitors > button {
          font-size: initial;
          color: white;
          text-shadow: none;
          background: @noti-bg;
          border: 1px solid @noti-border-color;
          box-shadow: none;
          border-radius: 12px;
        }
        .widget-inhibitors > button:hover {
          background: @noti-bg-hover;
        }
        .notification-row {
          outline: none;
        }

        .notification-row:focus,
        .notification-row:hover {
          background: alpha(@color14, 0.5); /* @noti-bg-focus */
        }

        .notification-row .notification-background {
          padding: 6px 12px;
        }

        .notification-row .notification-background .close-button {
          /* The notification Close Button */
          background: alpha(@color4, 0.5); /* @noti-close-bg */
          color: alpha(@color15, 1.0); /* @text-color */
          text-shadow: none;
          padding: 0;
          border-radius: 100%;
          margin-top: 5px;
          margin-right: 5px;
          box-shadow: none;
          border: none;
          min-width: 24px;
          min-height: 24px;
        }

        .notification-row .notification-background .close-button:hover {
          background: alpha(@color12, 0.5); /* @noti-close-bg-hover */
          transition: background 0.15s ease-in-out;
        }

        .notification-row .notification-background .notification {
          /* The actual notification */
          border-radius: 12px;
          border: 2px solid alpha(@color8, 0.5); /* @border */
          padding: 0;
          transition: background 0.15s ease-in-out;
          background: alpha(@color0, 0.5); /* @noti-bg */
        }

        .notification-row .notification-background .notification.low {
          /* Low Priority Notification */
        }

        .notification-row .notification-background .notification.normal {
          /* Normal Priority Notification */
        }

        .notification-row .notification-background .notification.critical {
          /* Critical Priority Notification */
        }

        .notification-row .notification-background .notification .notification-action,
        .notification-row .notification-background .notification .notification-default-action {
          padding: 4px;
          margin: 0;
          box-shadow: none;
          background: transparent;
          border: none;
          color: alpha(@color15, 1.0); /* @text-color */
          transition: background 0.15s ease-in-out;
        }

        .notification-row .notification-background .notification .notification-action:hover,
        .notification-row .notification-background .notification .notification-default-action:hover {
          background: alpha(@color13, 0.5); /* @noti-bg-hover */
        }

        .notification-row .notification-background .notification .notification-default-action {
          /* The large action that also displays the notification summary and body */
          border-radius: 12px;
        }

        .notification-row .notification-background .notification .notification-default-action:not(:only-child) {
          /* When alternative actions are visible */
          border-bottom-left-radius: 0px;
          border-bottom-right-radius: 0px;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content {
          background: transparent;
          border-radius: 12px;
          padding: 4px;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .image {
          /* Notification Primary Image */
          border-radius: 100px;
          /* Size in px */
          margin: 4px;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .app-icon {
          /* Notification app icon (only visible when the primary image is set) */
          -gtk-icon-shadow: 0 1px 4px black;
          margin: 6px;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .text-box .summary {
          /* Notification summary/title */
          font-size: 16px;
          font-weight: bold;
          background: transparent;
          color: alpha(@color15, 1.0); /* @text-color */
          text-shadow: none;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .text-box .time {
          /* Notification time-ago */
          font-size: 16px;
          font-weight: bold;
          background: transparent;
          color: alpha(@color15, 1.0); /* @text-color */
          text-shadow: none;
          margin-right: 30px;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .text-box .body {
          /* Notification body */
          font-size: 15px;
          font-weight: normal;
          background: transparent;
          color: alpha(@color15, 1.0); /* @text-color */
          text-shadow: none;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content progressbar {
          /* The optional notification progress bar */
          margin-top: 4px;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .body-image {
          /* The "extra" optional bottom notification image */
          margin-top: 4px;
          background-color: alpha(@color15, 0.5);
          border-radius: 12px;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply {
          /* The inline reply section */
          margin-top: 4px;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-entry {
          background: alpha(@color1, 0.5); /* @noti-bg-darker */
          color: alpha(@color15, 1.0); /* @text-color */
          caret-color: alpha(@color15, 1.0); /* @text-color */
          border: 1px solid alpha(@color8, 0.5); /* @border */
          border-radius: 12px;
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-button {
          margin-left: 4px;
          background: alpha(@color0, 0.5); /* @noti-bg */
          border: 1px solid alpha(@color8, 0.5); /* @border */
          border-radius: 12px;
          color: alpha(@color15, 1.0); /* @text-color */
        }

        .notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-button:disabled {
          background: initial;
          color: alpha(@color7, 0.5); /* @text-color-disabled */
          border: 1px solid alpha(@color8, 0.5); /* @border */
          border-color: transparent;
        }

        .notification-row .notification-background .notification .notification-default-action .inline-reply .inline-reply-button:hover {
          background: alpha(@color13, 0.5); /* @noti-bg-hover */
        }

        .notification-row .notification-background .notification .notification-action {
          /* The alternative actions below the default action */
          border-top: 1px solid alpha(@color8, 0.5); /* @border */
          border-radius: 0px;
          border-right: 1px solid alpha(@color8, 0.5); /* @border */
        }

        .notification-row .notification-background .notification .notification-action:first-child {
          /* Add bottom border radius to eliminate clipping */
          border-bottom-left-radius: 12px;
        }

        .notification-row .notification-background .notification .notification-action:last-child {
          border-bottom-right-radius: 12px;
          border-right: none;
        }

        .notification-group {
          /* Styling only for Grouped Notifications */
        }

        .notification-group.low {
          /* Low Priority Group */
        }

        .notification-group.normal {
          /* Normal Priority Group */
        }

        .notification-group.critical {
          /* Critical Priority Group */
        }

        .notification-group .notification-group-buttons,
        .notification-group .notification-group-headers {
          margin: 0 16px;
          color: alpha(@color15, 1.0); /* @text-color */
        }

        .notification-group .notification-group-headers {
          /* Notification Group Headers */
        }

        .notification-group .notification-group-headers .notification-group-icon {
          color: alpha(@color15, 1.0); /* @text-color */
        }

        .notification-group .notification-group-headers .notification-group-header {
          color: alpha(@color15, 1.0); /* @text-color */
        }

        .notification-group .notification-group-buttons {
          /* Notification Group Buttons */
        }

        .notification-group.collapsed .notification-row .notification {
          background-color: alpha(@color0, 0.5); /* @noti-bg-opaque */
        }

        .notification-group.collapsed .notification-row:not(:last-child) {
          /* Top notification in stack */
          /* Set lower stacked notifications opacity to 0 */
        }

        .notification-group.collapsed .notification-row:not(:last-child) .notification-action,
        .notification-group.collapsed .notification-row:not(:last-child) .notification-default-action {
          opacity: 0;
        }

        .notification-group.collapsed:hover .notification-row:not(:only-child) .notification {
          background-color: alpha(@color13, 0.5); /* @noti-bg-hover-opaque */
        }
    '';
  };
}
