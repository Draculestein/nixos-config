{ config, lib, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    mutableExtensionsDir = true;

    userSettings = {
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
              "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/\").nixosConfigurations.AlbertFlowX13.options";
            };
            "home-manager" = {
              "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/\").homeConfigurations.albertjul.options";
            };
          };
        };
      };
      "git.enableSmartCommit" = true;
      "workbench.iconTheme" = "catppuccin-macchiato";
      "redhat.telemetry.enabled" = false;
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "prettier.printWidth" = 100;
      "prettier.singleQuote" = true;
      "prettier.tabWidth" = 4;
      "prettier.useTabs" = true;
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "codium.codeCompletion.enable" = false;
      "codeium.enableConfig" = {
        "*" = true;
        "nix" = true;
      };
      "editor.inlineSuggest.suppressSuggestions" = true;
      "cody.commandCodeLenses" = true;
      "cody.autocomplete.enabled" = false;
      "yaml.format.enable" = false;
      "explorer.confirmDelete" = false;
      "typescript.updateImportsOnFileMove.enabled" = "always";
    };
  };
}
