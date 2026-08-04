{ den, ... }:
{
  den.aspects.code-dev = {
    includes = [
      den.aspects.vscode
      den.aspects.direnv
      den.aspects.gh
      den.aspects.lazygit
    ];

    nixos = {
      nix.settings = {
        substituters = [
          "https://devenv.cachix.org"
        ];

        trusted-public-keys = [
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
        ];
      };
    };

    homeManager = { pkgs, ... }: {
      programs.devenv = {
        enable = true;
        package = pkgs.devenv;

        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
