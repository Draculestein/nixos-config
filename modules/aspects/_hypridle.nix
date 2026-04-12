{ config, options, lib, pkgs, ... }:
let
  cfg = config.custom.hypridle;
  mkHyprIdleConfig = { afterSleepCmd, dpmsOffCmd, dpmsOnCmd, lockCmd, beforeSleepCmd, hasAsusKbdBacklight }:
    let
      brightnessTimeout = if hasAsusKbdBacklight then "150" else "300";
      kbdBlock =
        if hasAsusKbdBacklight then ''

        listener {
            timeout = 150
            on-timeout = brightnessctl -sd asus::kbd_backlight set 0
            on-resume = brightnessctl -rd asus::kbd_backlight
        }
      '' else "";
    in
    ''
      general {
          lock_cmd = ${lockCmd}
          before_sleep_cmd = ${beforeSleepCmd}
          after_sleep_cmd = ${afterSleepCmd}
      }

      listener {
          timeout = ${brightnessTimeout}
          on-timeout = brightnessctl -s set 1%
          on-resume = brightnessctl -r
      }
      ${kbdBlock}
      listener {
          timeout = 300
          on-timeout = systemd-ac-power || loginctl lock-session
      }

      listener {
          timeout = 330
          on-timeout = ${dpmsOffCmd}
          on-resume = ${dpmsOnCmd} && brightnessctl -r
      }

      listener {
          timeout = 1200
          on-timeout = systemd-ac-power || systemctl suspend
      }
    '';
in
{
  options.custom.hypridle.configs = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        afterSleepCmd = lib.mkOption {
          type = lib.types.str;
          description = "Command to run after waking from sleep";
        };
        dpmsOffCmd = lib.mkOption {
          type = lib.types.str;
          description = "Command to turn off monitors";
        };
        dpmsOnCmd = lib.mkOption {
          type = lib.types.str;
          description = "Command to turn on monitors";
        };
        lockCmd = lib.mkOption {
          type = lib.types.str;
          default = "pidof hyprlock || noctalia-shell ipc call lockScreen lock";
          description = "Command to lock the screen";
        };
        beforeSleepCmd = lib.mkOption {
          type = lib.types.str;
          default = "loginctl lock-session";
          description = "Command to run before sleep";
        };
        hasAsusKbdBacklight = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "If ASUS keyboard backlight is enabled";
        };
        compositorService = lib.mkOption {
          type = lib.types.str;
          description = "Systemd unit to bind the hypridle service to";
        };
      };
    });
    default = { };
    description = "Per-DE hypridle configurations";
  };

  config = lib.mkIf (cfg.configs != { }) {
    home.packages = [ pkgs.hypridle ];

    xdg.configFile = lib.mapAttrs'
      (name: deCfg:
        lib.nameValuePair "hypr/hypridle-${name}.conf" {
          text = mkHyprIdleConfig {
            inherit (deCfg) afterSleepCmd dpmsOffCmd dpmsOnCmd lockCmd beforeSleepCmd hasAsusKbdBacklight;
          };
        }
      )
      cfg.configs;

    systemd.user.services = lib.mapAttrs'
      (name: deCfg:
        lib.nameValuePair "hypridle-${name}" {
          Unit = {
            Description = "Hypridle idle daemon (${name})";
            BindsTo = [ deCfg.compositorService ];
            After = [ deCfg.compositorService ];
            Requisite = [ deCfg.compositorService ];
          };
          Service = {
            ExecStartPre = "${pkgs.coreutils}/bin/ln -sf %h/.config/hypr/hypridle-${name}.conf %h/.config/hypr/hypridle.conf";
            ExecStart = "${pkgs.hypridle}/bin/hypridle";
          };
          Install.WantedBy = [ deCfg.compositorService ];
        }
      )
      cfg.configs;
  };
}
