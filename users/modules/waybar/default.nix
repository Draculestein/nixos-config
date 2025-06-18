{ config, pkgs, lib, ... }: {
  home.packages = with pkgs;[
    lm_sensors
    rofi-wayland
    bluetui
  ];

  # For MPRIS
  services.playerctld.enable = true;

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };

    settings = {
      mainbar = {
        layer = "top";
        position = "top";
        mode = "dock";
        gtk-layer-shell = true;

        modules-left = [
          "custom/left1"
          "niri/workspaces"
          "custom/right1"
          "custom/paddw"
          "niri/window"
        ];

        modules-center = [
          "custom/paddc"
          "custom/left2"
          "custom/temparature"

          "custom/left3"
          "memory"

          "custom/left4"
          "cpu"
          "custom/leftin1"

          "custom/left5"
          "custom/distro"
          "custom/right2"

          "custom/rightin1"
          "idle_inhibitor"
          "clock#time"
          "custom/right3"

          "clock#date"
          "custom/right4"

          "custom/wifi"
          "bluetooth"
          "custom/right5"
        ];

        modules-right = [
          "mpris"

          "custom/left6"
          "wireplumber"

          "custom/left7"
          "backlight"

          "custom/left8"
          "battery"

          "custom/leftin2"
          "custom/power"
        ];

        "niri/window" = {
          "format" = "{}";
          "tooltip" = false;
          "min-length" = 5;

          "rewrite" = {
            # ───────────────────────────────────────────────────────── terminal ───

            "~" = "  Terminal";
            "zsh" = "  Terminal";
            "kitty" = "  Terminal";

            "tmux(.*)" =
              "<span foreground='#a6e3a1'> </span> Tmux";

            # ────────────────────────────────────────────────────────── browser ───

            "(.*)Mozilla Firefox" =
              "<span foreground='#f38ba8'>󰈹 </span> Firefox";
            "(.*) — Mozilla Firefox" =
              "<span foreground='#f38ba8'>󰈹 </span> $1";

            "(.*)Zen Browser" =
              "<span foreground='#fab387'>󰺕 </span> Zen Browser";
            "(.*) — Zen Browser" =
              "<span foreground='#fab387'>󰺕 </span> $1";

            # ────────────────────────────────────────────────────── development ───

            "(.*) - Visual Studio Code" =
              "<span foreground='#89b4fa'>󰨞 </span> $1";
            "(.*)Visual Studio Code" =
              "<span foreground='#89b4fa'>󰨞 </span> Visual Studio Code";

            "nvim" =
              "<span foreground='#a6e3a1'> </span> Neovim";
            "nvim (.*)" =
              "<span foreground='#a6e3a1'> </span> $1";

            "vim" =
              "<span foreground='#a6e3a1'> </span> Vim";
            "vim (.*)" =
              "<span foreground='#a6e3a1'> </span> $1";

            # ──────────────────────────────────────────────────────────── media ───

            "(.*)Spotify" =
              "<span foreground='#a6e3a1'> </span> Spotify";
            "(.*)Spotify Premium" =
              "<span foreground='#a6e3a1'> </span> Spotify Premium";

            "OBS(.*)" =
              "<span foreground='#a6adc8'>󰻃 </span> OBS Studio";

            "VLC media player" =
              "<span foreground='#fab387'>󰕼 </span> VLC Media Player";
            "(.*) - VLC media player" =
              "<span foreground='#fab387'>󰕼 </span> $1";

            "(.*) - mpv" =
              "<span foreground='#cba6f7'> </span> $1";

            "qView" = "󰋩  qView";

            "(.*).jpg" = "󰋩  $1.jpg";
            "(.*).png" = "󰋩  $1.png";
            "(.*).svg" = "󰋩  $1.svg";

            # ─────────────────────────────────────────────────────────── social ───

            "• Discord(.*)" = "Discord$1";
            "(.*)Discord(.*)" =
              "<span foreground='#89b4fa'> </span> $1Discord$2";

            "vesktop" =
              "<span foreground='#89b4fa'> </span> Discord";

            # ──────────────────────────────────────────────────────── documents ───

            "ONLYOFFICE Desktop Editors" =
              "<span foreground='#f38ba8'> </span> OnlyOffice Desktop";

            "(.*).docx" =
              "<span foreground='#89b4fa'>󰈭 </span> $1.docx";
            "(.*).xlsx" =
              "<span foreground='#a6e3a1'>󰈜 </span> $1.xlsx";
            "(.*).pptx" =
              "<span foreground='#fab387'>󰈨 </span> $1.pptx";
            "(.*).pdf" =
              "<span foreground='#f38ba8'> </span> $1.pdf";

            # ─────────────────────────────────────────────────────────── system ───
            "Authenticate" = "  Authenticate";
          };
        };

        "custom/temperature" = {
          "exec" = "~/.config/waybar/scripts/cpu-temp.sh";
          "return-type" = "json";
          "format" = "{}";
          "interval" = 5;
          "min-length" = 8;
          "max-length" = 8;
        };

        "memory" = {
          "states" = {
            "warning" = 75;
            "critical" = 90;
          };

          "format" = "󰘚 {percentage}%";
          "format-critical" = "󰀦 {percentage}%";
          "tooltip" = false;
          "tooltip-format" = "Memory Used: {used=0.1f} GB / {total=0.1f} GB";
          "interval" = 5;
          "min-length" = 7;
          "max-length" = 7;
        };

        "cpu" = {
          "format" = "󰍛 {usage}%";
          "tooltip" = false;
          "interval" = 5;
          "min-length" = 6;
          "max-length" = 6;
        };

        "custom/distro" = {
          "format" = " ";
          "tooltip" = false;
        };

        "idle_inhibitor" = {
          "format" = "{icon}";

          "format-icons" = {
            "activated" = "󰈈 ";
            "deactivated" = "󰈉 ";
          };

          "tooltip-format-activated" = "Presentation Mode";
          "tooltip-format-deactivated" = "Idle Mode";
          "start-activated" = false;
        };

        "clock#time" = {
          "format" = "{:%H:%M:%S}";
          "tooltip" = false;
          "interval" = 1;
          "min-length" = 6;
          "max-length" = 10;
        };

        "clock#date" = {
          "format" = "󰸗 {:%b %d}";
          "tooltip-format" = "<tt>{calendar}</tt>";

          "calendar" = {
            "mode" = "month";
            "mode-mon-col" = 6;
            "on-click-right" = "mode";

            "format" = {
              "months" =
                "<span color='#b4befe'><b>{}</b></span>";
              "weekdays" =
                "<span color='#a6adc8' font='7'>{}</span>";
              "today" =
                "<span color='#f38ba8'><b>{}</b></span>";
            };
          };

          "actions" = {
            "on-click" = "mode";
            "on-click-right" = "mode";
          };

          "min-length" = 8;
          "max-length" = 12;
        };

        "custom/wifi" = {
          "exec" = "~/.config/waybar/scripts/wifi-status.sh";
          "return-type" = "json";
          "format" = "{}";
          "on-click" = "~/.config/waybar/scripts/wifi-menu.sh";
          "on-click-right" = "ghostty --title '󰤨  Network Manager TUI' -e nmtui";
          "interval" = 1;
          "min-length" = 1;
          "max-length" = 1;
        };

        "bluetooth" = {
          "format" = "󰂰";
          "format-disabled" = "󰂲";
          "format-connected" = "󰂱";
          "format-connected-battery" = "󰂱";

          "tooltip-format" =
            "{num_connections} connected";
          "tooltip-format-disabled" =
            "Bluetooth Disabled";
          "tooltip-format-connected" =
            "{device_enumerate}";
          "tooltip-format-enumerate-connected" =
            "{device_alias}";
          "tooltip-format-enumerate-connected-battery" =
            "== {device_alias}= 󱊣 {device_battery_percentage}%";

          "on-click" = "~/.config/waybar/scripts/bluetooth-menu.sh";
          "on-click-right" = "ghostty --title '󰂯  Bluetooth TUI' -e bluetui";
          "interval" = 1;
          "min-length" = 1;
          "max-length" = 1;
        };

        "mpris" = {
          "format" = "{player_icon} {title} - {artist}";
          "format-paused" = "{status_icon} {title} - {artist}";

          "player-icons" = {
            "default" = "󰝚 ";
            "spotify" = "<span foreground='#a6e3a1'>󰓇 </span>";
            "firefox" = "<span foreground='#f38ba8'>󰗃 </span>";
          };
          "status-icons" = {
            "paused" = ''<span color='#b4befe'>  󰏤  </span>'';
          };

          "tooltip-format" = "Playing: {title} - {artist}";
          "tooltip-format-paused" = "Paused: {title} - {artist}";
          "min-length" = 5;
          "max-length" = 35;
        };

        "wireplumber" = {
          "format" = "{icon} {volume}%";
          "format-muted" = "󰝟 {volume}%";
          "max-volume" = 110;
          "format-icons" = [ "󰕿" "󰖀" "󰕾" ];
          "tooltip" = true;
          "tooltip-format" = "Device: {node_name}";
          "min-length" = 6;
          "max-length" = 6;
        };

        "backlight" = {
          "format" = "{icon} {percent}%";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
          "tooltip" = false;
          "on-scroll-up" = "~/.config/waybar/scripts/brightness-control.sh -o i";
          "on-scroll-down" = "~/.config/waybar/scripts/brightness-control.sh -o d";
          "min-length" = 6;
          "max-length" = 6;
        };

        "battery" = {
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };

          "format" = "{icon} {capacity}%";
          "format-icons" = [ "󰂎" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          "format-charging" = " {capacity}%";

          "tooltip-format" = "Discharging: {time}";
          "tooltip-format-charging" = "Charging: {time}";
          "interval" = 1;
          "min-length" = 6;
          "max-length" = 6;
        };

        "custom/power" = {
          "format" = " ";
          "tooltip" = false;
          "on-click" = "~/.config/waybar/scripts/power-menu.sh";
        };
        # ────────────────────────────────────────────────────────────┤ padding ├───

        "custom/paddw" = {
          "format" = " ";
          "tooltip" = false;
        };

        "custom/paddc" = {
          "format" = " ";
          "tooltip" = false;
        };

        # ────────────────────────────────────────────────────────┤ left arrows ├───

        "custom/left1" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left2" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left3" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left4" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left5" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left6" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left7" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left8" = {
          "format" = "";
          "tooltip" = false;
        };

        # ───────────────────────────────────────────────────────┤ right arrows ├───

        "custom/right1" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right2" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right3" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right4" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right5" = {
          "format" = "";
          "tooltip" = false;
        };

        # ───────────────────────────────────────────────────────┤ left inverse ├───

        "custom/leftin1" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/leftin2" = {
          "format" = "";
          "tooltip" = false;
        };

        # ──────────────────────────────────────────────────────┤ right inverse ├───

        "custom/rightin1" = {
          "format" = "";
          "tooltip" = false;
        };
      };
    };

    style = null;
  };
}
