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
      control-center-layer = "overlay";
      control-center-margin-top = 2;
      control-center-margin-bottom = 2;
      control-center-margin-right = 1;
      control-center-margin-left = 0;
      control-center-width = 450;
      control-center-height = 1200;
      notification-2fa-action = true;
      notification-inline-replies = true;
      notification-icon-size = 32;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-window-width = 350;
      fit-to-screen = true;

      timeout = 4;
      timeout-low = 2;
      timeout-critical = 0;

      widgets = [
        "title"
        "dnd"
        "volume"
        "backlight"
        "notifications"
      ];
      "widget-config" = {
        "title" = {
          "text" = "󰂚   Notifications";
          "clear-all-button" = true;
          "button-text" = " 󰎟 ";
        };
        "dnd" = {
          "text" = "Do not disturb";
        };
        "label" = {
          "max-lines" = 1;
          "text" = "Notification Center";
        };
        "mpris" = {
          "image-size" = 96;
          "image-radius" = 10;
        };
        "volume" = {
          "label" = "󰕾 ";
          "show-per-app" = true;
        };
        "backlight" = {
          "label" = "󰃟 ";
          "subsystem" = "backlight";
          "device" = "amdgpubl2";
        };
      };
    };

    style = ''
      @define-color color1 #${config.lib.stylix.colors.base05}
      @define-color color0 #${config.lib.stylix.colors.base0E}
      @define-color background #${config.lib.stylix.colors.base00}
      @define-color foreground #${config.lib.stylix.colors.base06}
      @define-color noti-close-bg #${config.lib.stylix.colors.base02}
      @define-color noti-close-bg-hover #${config.lib.stylix.colors.base03}
      @define-color noti-border-color #${config.lib.stylix.colors.base01}
      @define-color foreground-disabled #${config.lib.stylix.colors.base04}
      @define-color brgreen #${config.lib.stylix.colors.base0B}

      * {
          font-family: Cantarell;
          /* font-weight: bolder; */
      }

      .control-center .notification-row:focus,
      .control-center .notification-row:hover {
          opacity: 1;
          background: alpha(@color1, 0.8);
          border-radius: 0px;
          margin: 0px;
      }

      .notification {
          border-radius: 10px;
          padding: 0;
          border: 2px solid alpha(@color1, 1);
          background: @color0;
          box-shadow: 0 0 5px 0 rgba(0, 0, 0, 0.75);
      }

      .notification-content {
          background: transparent;
          padding: 10px;
      }

      .close-button {
          background: alpha(@foreground, 0.1);
          color: @color1;
          text-shadow: none;
          padding: 0;
          border-radius: 100%;
          margin-top: 20px;
          margin-right: 13px;
          box-shadow: none;
          border: none;
          min-width: 24px;
          min-height: 24px
      }

      .close-button:hover {
          box-shadow: none;
          background: @color1;
          color: @background;
          transition: all .15s ease-in-out;
          border: none
      }

      .notification-default-action,
      .notification-action {
          padding: 4px;
          margin: 0;
          box-shadow: none;
          background: @background;
          border: none;
          color: @foreground;
          transition: all .15s ease-in-out;
          font-size: 10.5pt;
      }

      .notification-default-action:hover,
      .notification-action:hover {
          -gtk-icon-effect: none;
          background: @color0;
          /* text-shadow: 0 0 3px @foreground; */
      }

      .notification-default-action {
          border-radius: 8px
      }

      .notification-default-action:not(:only-child) {
          border-bottom-left-radius: 0;
          border-bottom-right-radius: 0
      }

      .notification-action {
          border-radius: 0;
          border-top: none;
          border-right: none
      }

      .notification-action:first-child {
          border-bottom-left-radius: 10px;
          background: @background
      }

      .notification-action:last-child {
          border-bottom-right-radius: 10px;
          background: @background
      }

      .notification-group-headers {
        font-weight: bold;
        font-size: 10.5pt;
        color: @foreground;
      }

      .notification-group-icon {
        color: @color1;
        margin-right: 8px;
      }

      .notification-group-collapse-button {
        background: @noti-close-bg;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }

      .notification-group-collapse-button:hover {
        background: @noti-close-bg-hover;
        color: @color1;
      }

      .notification-group-close-all-button {
        background: @noti-close-bg;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }

      .notification-group-close-all-button:hover {
        background: @noti-close-bg-hover;
        color: @color1
      }

      .inline-reply {
          margin-top: 8px
      }

      .inline-reply-entry {
          background: @color0;
          color: @foreground;
          caret-color: @foreground;
          border: 1px solid @noti-border-color;
          border-radius: 10px
      }

      .inline-reply-button {
          margin-left: 4px;
          background: @background;
          border: 1px solid @noti-border-color;
          border-radius: 10px;
          color: @foreground
      }

      .inline-reply-button:disabled {
          background: initial;
          color: @foreground-disabled;
          border: 1px solid transparent
      }

      .inline-reply-button:hover {
          background: @color0;
      }

      .body-image {
          margin-top: 0px;
          background-color: transparent;
          border-radius: 10px
      }

      .summary {
          font-size: 10.5pt;
          font-weight: bold;
          font-style: italic;
          background: transparent;
          color: @color1;
          margin-left: 10px;
          /* text-shadow: 0 0 3px @color1; */
      }

      .time {
          font-size: 10.5pt;
          font-weight: bold;
          font-style: italic;
          background: transparent;
          color: @brgreen;
          text-shadow: none;
          margin-right: 10px
      }

      .body {
          font-size: 10.5pt;
          font-weight: normal;
          background: transparent;
          color: @foreground;
          text-shadow: none;
          font-weight: bold;
          margin-left: 10px;
      }

      .image {
          background: transparent;
          border-radius: 8px;
      }

      .control-center {
          background: alpha(@background, 1);
          border-left: 1px solid @noti-close-bg;
          border-radius: 0px;
          margin-left: 10px;
          box-shadow: 0 0 5px 0 rgba(0, 0, 0, 1);
      }

      .control-center-list {
          background: transparent;
      }

      .control-center-list-placeholder {
          opacity: .5
      }

      .floating-notifications .notification-row {
          background: transparent;
          margin: 15px 10px 0 0;
      }

      .blank-window {
          background: alpha(black, 0.0)
      }

      .widget-title {
          color: @color1;
          margin: 20px 20px 5px 20px;
          font-size: 10.5pt;
          font-weight: bold;
          font-style: italic;
          /* text-shadow: 0 0 3px @color1; */
      }

      .widget-title>button {
          font-size: initial;
          font-weight: bold;
          font-family: 'Symbols Nerd Font';
          color: @brgreen;
          text-shadow: none;
          background: @background;
          border: 1px solid @noti-border-color;
          box-shadow: none;
          border-radius: 10px;
      }

      .widget-title>button:hover {
          background: @color0;
          /* text-shadow: 0 0 3px @brgreen; */
      }

      .widget-dnd {
          color: @foreground;
          margin: 5px 20px 5px 20px;
          font-size: 10.5pt;
          font-weight: bold;
      }

      .widget-dnd>switch {
          font-size: initial;
          border-radius: 999px;
          background: @background;
          /* border: 1px solid @background; */
          box-shadow: none;
          padding: 1px;
          transition: all .1s ease-in-out;
      }

      .widget-dnd>switch:checked {
          background: @foreground
      }

      .widget-dnd>switch slider {
          background: @color0;
          border-radius: 999px
      }

      .widget-label {
          margin: 10px;
      }

      .widget-label>label {
          font-size: 1.5rem;
          color: @foreground;
      }

      .widget-mpris {
          color: @foreground;
          background: @background;
          padding: 10px;
          margin: 10px;
          border: 1px solid @noti-close-bg;
          border-radius: 10px;
          box-shadow: 0 0 5px 0 rgba(0, 0, 0, 1);
      }

      .widget-mpris-player {
          padding: 0px;
          margin: 0px
      }

      .widget-mpris-title {
          font-weight: bold;
          font-size: 1.25rem
      }

      .widget-mpris-subtitle {
          font-size: 1.1rem
      }

      .widget-buttons-grid {
          font-size: x-large;
          padding: 8px;
          margin: 20px 10px 10px;
          border: 1px solid @noti-close-bg;
          border-radius: 10px;
          background: @background;
          box-shadow: 0 0 5px 0 rgba(0, 0, 0, 1);
      }

      .widget-buttons-grid>flowbox>flowboxchild>button {
          margin: 3px;
          background: transparent;
          border-radius: 10px;
          color: @foreground
      }

      .widget-buttons-grid>flowbox>flowboxchild>button:hover {
          /* background: @color0; */
          color: @brgreen;
          /* text-shadow: 0 0 3px @foreground; */
      }

      .widget-menubar>box>.menu-button-bar>button {
          border: none;
          background: transparent
      }

      .topbar-buttons>button {
          border: none;
          background: transparent
      }

      .widget-volume {
          background: @background;
          padding: 8px;
          padding-left: 16px;
          margin: 10px;
          border: 2px solid alpha(@foreground, 0.1);
          border-radius: 8px;
          font-size: x-large;
          color: @color1;
      }

      .widget-volume>box>button {
          background: @color1;
          border: 1px solid @noti-close-bg;
      }

      .per-app-volume {
          background-color: @background;
          padding: 4px 8px 8px;
          margin: 0 8px 8px;
          border-radius: 10px
      }

      .widget-backlight {
          background: @background;
          padding: 8px;
          padding-left: 16px;
          margin: 10px;
          border: 1px solid @noti-close-bg;
          border-radius: 8px;
          font-size: x-large;
          color: @color1;
      }

      .widget-inhibitors {
          margin: 8px;
          font-size: 1.5rem
      }

      .widget-inhibitors>button {
          font-size: initial;
          color: @foreground;
          text-shadow: none;
          background: @background;
          border: 1px solid @noti-border-color;
          box-shadow: none;
          border-radius: 10px
      }

      .widget-inhibitors>button:hover {
          background: @color0
      }    
    '';
  };
}
