{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs;[
    devenv
  ];


  nix.settings = {
    substituters = [
      "https://nixpkgs-python.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw= nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
    ];
  };
}
