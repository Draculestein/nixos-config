{
  config, pkgs, lib, ... }:
    {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "small";
            padding = {
              top = 1;
              right = 2;
            };
          };
          display = {
            separator = "=>  ";
            color = {
              separator = "red";
            };
            constants = [
              "───────────────────────────────────────────────────────────────────────────"
              
            ];
          };
          modules = [
            {
              format = "{#1}{#keys}╭{$1}╮\\u001b[76D {user-name-colored}{at-symbol-colored}{host-name-colored} 🖥  ";
              type = "title";
            }
            {
              key = "{$2}{#31} kernel   ";
              type = "kernel";
            }
            {
              key = "{$2}{#32}󰅐 uptime   ";
              type = "uptime";
            }
            {
              key = "{$2}{#33}{icon} distro   ";
              type = "os";
            }
            {
              key = "{$2}{#34}󰇄 desktop  ";
              type = "de";
            }
            {
              key = "{$2}{#35} term     ";
              type = "terminal";
            }
            {
              key = "{$2}{#36} shell    ";
              type = "shell";
            }
            {
              key = "{$2}{#35}󰍛 cpu      ";
              type = "cpu";
              showPeCoreCount = true;
              temp = true;
            }
            {
              key = "{$2}{#34}󰍛 gpu      ";
              type = "gpu";
            }
            {
              key = "{$2}{#33}󰉉 disk     ";
              type = "disk";
              folders = "/";
            }
            {
              key = "{$2}{#32} memory   ";
              type = "memory";
            }
            {
              key = "{$2}{#31}󰩟 network  ";
              type = "localip";
              format = "{ipv4} ({ifname})";
            }
            {
              format = "{#1}{#keys}├{$1}┤";
              type = "custom";
            }
            {
              key = "{$2}{#39} colors   ";
              type = "colors";
              symbol = "circle";
            }
            {
              format = "{#1}{#keys}╰{$1}╯";
              type = "custom";
            }
          ];
        };

      };
    }
