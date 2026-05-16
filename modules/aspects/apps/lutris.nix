{ den, ... }:
{
  den.aspects.lutris = {
    homeManager = { config, lib, pkgs, ... }: {
      home.packages = with pkgs; [
        (lutris.override {
          extraPkgs = pkgs: [
            winetricks
          ];
        })
      ];
    };
  };
}
