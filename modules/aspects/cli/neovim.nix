{ den, inputs, ... }:
{
  flake-file.inputs = {
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.neovim = {
    nixos = {
      nixpkgs.overlays = [
        (_: prev: {
          # nixos-unstable: https://github.com/NixOS/nixpkgs/pull/572951
          typescript-language-server =
            if prev.typescript-language-server.version == "6.0.2" && prev.typescript-language-server ? pnpmDeps then
              prev.typescript-language-server.overrideAttrs (old: {
                pnpmDeps = old.pnpmDeps.override {
                  hash = "sha256-xR/EF60lVBsITKgH7wCM2wHM46PFQevD51KfCENSUH4=";
                };
              })
            else
              prev.typescript-language-server;
        })
      ];
    };

    homeManager = { pkgs, ... }: {
      imports = [ inputs.nvf.homeManagerModules.default ];

      home.packages = with pkgs; [
        ripgrep
      ];

      programs.nvf = {
        enable = true;
        settings = {
          vim.viAlias = false;
          vim.vimAlias = true;
          vim.lsp = {
            enable = true;
          };

          vim.globals.mapleader = " ";
          vim.globals.maplocalleader = ",";
          vim.hideSearchHighlight = true;

          vim.clipboard = {
            enable = true;
            providers = {
              wl-copy.enable = true;
            };
          };

          vim.treesitter = {
            enable = true;
            indent.enable = true;
          };

          vim.languages = {
            typescript = {
              enable = true;

              format = {
                enable = true;
                type = [ "prettier" ];
              };

              lsp = {
                enable = true;
                servers = [ "typescript-language-server" ];
              };

              treesitter.enable = true;
            };
            nix = {
              enable = true;
              lsp = {
                enable = true;
                servers = [ "nixd" ];
              };
              format = {
                enable = true;
                type = [ "nixfmt" ];
              };

              treesitter.enable = true;
            };
          };
        };
      };
    };
  };
}
