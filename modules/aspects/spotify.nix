{ den, ... }:
{
  den.aspects.spotify = {
    homeManager = { config, lib, pkgs, inputs, ... }: {
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
