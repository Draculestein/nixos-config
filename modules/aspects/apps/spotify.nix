{ den, inputs, ... }:
{
  flake-file.inputs.spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  den.aspects.spotify = {
    homeManager = { config, lib, pkgs, ... }: {
      imports = [
        inputs.spicetify-nix.homeManagerModules.default
      ];

      programs.spicetify =
        let
          spicetify-pkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
        in
        {
          enable = true;

          enabledExtensions = with spicetify-pkgs.extensions; [
            fullAppDisplay
          ];
        };
    };
  };
}
