{ den, inputs, ... }:
{
  flake-file.inputs.dwproton.url = "github:imaviso/dwproton-flake";

  den.aspects.steam = {
    nixos = { config, lib, pkgs, ... }: {
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        package = pkgs.steam.override {
          extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
          extraPkgs = pkgs:
            with pkgs; [
              xorg.libXcursor
              xorg.libXi
              xorg.libXinerama
              xorg.libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
              libkrb5
              keyutils
              gamemode
            ];
        };
        extraCompatPackages = [
          pkgs.proton-ge-bin
          inputs.dwproton.packages.${pkgs.stdenv.hostPlatform.system}.dw-proton
        ];
      };

      programs.gamescope = {
        enable = true;
        capSysNice = false;
      };

      programs.gamemode.enable = true;
    };
  };
}
