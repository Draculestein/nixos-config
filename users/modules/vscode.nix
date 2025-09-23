{ config, lib, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default.enableUpdateCheck = false;
    mutableExtensionsDir = true;

    profiles.default.userSettings = {
      "editor.fontFamily" = "'Hasklug Nerd Font', 'monospace', monospace";
      "editor.tabSize" = 2;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.inlineSuggest.suppressSuggestions" = true;
      "editor.accessibilitySupport" = "off";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.startupEditor" = "welcomePage";
      "window.restoreWindows" = "none";

      "git.confirmSync" = false;
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;

      "prettier.printWidth" = 100;
      "prettier.singleQuote" = true;
      "prettier.tabWidth" = 2;
      "prettier.useTabs" = false;

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

      # Language formatter settings
      "[dockerfile]" = {
        "editor.defaultFormatter" = "ms-azuretools.vscode-containers";
      };
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "[erb]" = {
        "editor.defaultFormatter" = "Shopify.ruby-lsp";
      };
      "python.analysis.typeCheckingMode" = "standard";

      "redhat.telemetry.enabled" = false;

      "cody.commandCodeLenses" = true;
      "cody.autocomplete.enabled" = false;
      "yaml.format.enable" = false;
      "explorer.confirmDelete" = false;
      "typescript.updateImportsOnFileMove.enabled" = "always";
      "chat.commandCenter.enabled" = false;
      "cody.suggestions.mode" = "off";
      "amp.url" = "https://ampcode.com/";
      "docker.extension.enableComposeLanguageServer" = true;
      "chat.instructionsFilesLocations" = {
        ".github/instructions" = true;
        "/tmp/postman-http-request-post-response.instructions.md" = true;
        "/tmp/postman-http-request-pre-request.instructions.md" = true;
        "/tmp/postman-collections-post-response.instructions.md" = true;
        "/tmp/postman-collections-pre-request.instructions.md" = true;
        "/tmp/postman-folder-post-response.instructions.md" = true;
        "/tmp/postman-folder-pre-request.instructions.md" = true;
      };
      "postman.mcp.notifications.postmanMCP" = false;

    };
  };
}
