{ config, lib, pkgs, ... }:
{

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "s"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 150; # 2.5min.
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }

        # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
        {
          timeout = 150; # 2.5min.
          on-timeout = "brightnessctl -sd asus::kbd_backlight set 0"; # turn off keyboard backlight.
          on-resume = "brightnessctl -rd asus::kbd_backlight"; # turn on keyboard backlight.
        }

        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }

        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }

        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      # /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
      # Hyprlock config for =< 1080p monitor resolutions                                                        
      # Original config submitted by https://github.com/SherLock707

      # # Sourcing colors generated by wallust
      # source = $HOME/.config/hypr/wallust/wallust-hyprland.conf
      # $Scripts = $HOME/.config/hypr/scripts

      general = {
        grace = 2;
      };

      background = [
        {
          monitor = "";
          path = "$HOME/.dotfiles/users/albertjul/desktop.jpg";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 3;
          dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgb(${config.lib.stylix.colors.base05})";
          inner_color = "rgb(${config.lib.stylix.colors.base00})";
          font_color = "rgb(${config.lib.stylix.colors.base0C})";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>"; # Text rendered in the input box when it's empty.
          hide_input = false;

          position = "0, 80";
          halign = "center";
          valign = "bottom";
        }
      ];

      label = [
        # Date
        {
          monitor = "";
          text = "cmd[update:18000000] echo \"<b> \"$(date +'%A, %-d %B %Y')\" </b>\"";
          color = "rgb(${config.lib.stylix.colors.base0C})";
          font_size = 34;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, -80";
          halign = "center";
          valign = "top";
        }
        # Hour-Time
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%H\")\"";
          #    text = cmd[update:1000] echo "$(date +"%I")" #AM/PM
          color = "rgb(${config.lib.stylix.colors.base05})";
          font_size = 150;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -200";
          halign = "center";
          valign = "top";
        }
        # Minute-Time
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%M\")\"";
          color = "rgb(${config.lib.stylix.colors.base06})";
          font_size = 150;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -450";
          halign = "center";
          valign = "top";
        }

        # Seconds-Time
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%S\")\"";
          #    text = cmd[update:1000] echo "$(date +"%S %p")" #AM/PM
          color = "rgb(${config.lib.stylix.colors.base0C})";
          font_size = 20;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -450";
          halign = "center";
          valign = "top";
        }

        # User
        {
          monitor = "";
          text = "   $USER";
          color = "rgb(${config.lib.stylix.colors.base0A})";
          font_size = 18;
          font_family = "Inter Display Medium";

          position = "0, 20";
          halign = "center";
          valign = "bottom";
        }
      ];

    };
  };
}
