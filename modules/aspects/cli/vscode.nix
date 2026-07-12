{ den, ... }:
{

  den.aspects.vscode = {
    includes = [ (den.batteries.unfree [ "vscode" ]) ];

    homeManager = { pkgs, ... }: {
      programs.vscode = {
        enable = true;
        profiles.default.enableUpdateCheck = false;
        mutableExtensionsDir = true;

        profiles.default.userSettings = {
          "chat.disableAIFeatures" = true;
          "editor.fontFamily" = "'Hasklug Nerd Font', 'monospace', monospace";
          "editor.tabSize" = 2;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.inlineSuggest.suppressSuggestions" = true;
          "editor.accessibilitySupport" = "off";
          "workbench.iconTheme" = "catppuccin-macchiato";
          "workbench.startupEditor" = "welcomePage";
          "window.restoreWindows" = "none";
          "terminal.integrated.suggest.enabled" = false;
          "terminal.integrated.initialHint" = false;

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
                  "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/flake.nix\").nixosConfigurations.AlbertProP16.options";
                };
                "home-manager" = {
                  "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/flake.nix\").nixosConfigurations.AlbertProP16.options.home-manager.users.type.getSubOptions []";
                };
                "flake-parts" = {
                  "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/flake.nix\").debug.options";
                };
                "flake-parts2" = {
                  "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/flake.nix\").currentSystem.options";
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
          "[toml]" = {
            "editor.defaultFormatter" = "tamasfe.even-better-toml";
          };
          "[python]" = {
            "editor.defaultFormatter" = "charliermarsh.ruff";
          };
          "[cpp]" = {
            "editor.defaultFormatter" = "ms-vscode.cpptools";
          };
          "python.analysis.typeCheckingMode" = "standard";

          "redhat.telemetry.enabled" = false;
          "yaml.format.enable" = false;
          "explorer.confirmDelete" = false;
          "typescript.updateImportsOnFileMove.enabled" = "always";
          "chat.commandCenter.enabled" = false;
          "docker.extension.enableComposeLanguageServer" = true;
          "chat.instructionsFilesLocations" = {
            ".github/instructions" = true;
            ".claude/rules" = true;
            "/tmp/postman-http-request-post-response.instructions.md" = true;
            "/tmp/postman-http-request-pre-request.instructions.md" = true;
            "/tmp/postman-collections-post-response.instructions.md" = true;
            "/tmp/postman-collections-pre-request.instructions.md" = true;
            "/tmp/postman-folder-post-response.instructions.md" = true;
            "/tmp/postman-folder-pre-request.instructions.md" = true;
          };
          "postman.mcp.notifications.postmanMCP" = false;
          "chat.mcp.gallery.enabled" = true;
          "files.associations" = {
            ".env*" = "dotenv";
          };
        };
      };
    };
  };
}
