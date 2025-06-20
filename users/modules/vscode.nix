{ config, lib, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default.enableUpdateCheck = false;
    mutableExtensionsDir = true;

    profiles.default.userSettings = {
      "editor.fontFamily" = "'Hasklug Nerd Font', 'monospace', monospace";
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "nixpkgs-fmt";
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [ "nixpkgs-fmt" ];
          };
          "options" = {
            "nixos" = {
              "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/flake.nix\").nixosConfigurations.AlbertFlowX13.options";
            };
            "home-manager" = {
              "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/flake.nix\").homeConfigurations.albertjul.options";
            };
          };
        };
      };
      "git.enableSmartCommit" = true;
      "workbench.iconTheme" = "catppuccin-macchiato";
      "redhat.telemetry.enabled" = false;

      # Language formatter settings
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[css]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[vue]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[scss]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "prettier.printWidth" = 100;
      "prettier.singleQuote" = true;
      "prettier.tabWidth" = 4;
      "prettier.useTabs" = true;
      "editor.inlineSuggest.suppressSuggestions" = true;
      "cody.commandCodeLenses" = true;
      "cody.autocomplete.enabled" = false;
      "yaml.format.enable" = false;
      "explorer.confirmDelete" = false;
      "typescript.updateImportsOnFileMove.enabled" = "always";
      "chat.commandCenter.enabled" = false;
      "cody.suggestions.mode" = "off";
      "editor.accessibilitySupport" = "off";
      "workbench.startupEditor" = "welcomePage";
      "window.restoreWindows" = "none";
    };
  };
}
