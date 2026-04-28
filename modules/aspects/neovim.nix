{ den, inputs, ... }:
{
  flake-file.inputs = {
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.neovim = {
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
