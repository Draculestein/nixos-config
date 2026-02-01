{ den, ... }:
{
  den.aspects.ghostty = {
    homeManager = { pkgs, inputs, ... }: {
      home.packages = [
        inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
}
