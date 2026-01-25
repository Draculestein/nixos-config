{ den, inputs, ... }:
{
  flake-file.inputs.stylix.url = "github:nix-community/stylix";

  den.aspects.stylix = {
    nixos = { pkgs, ... }: {
      imports = [ inputs.stylix.nixosModules.stylix ];

      stylix = {
        enable = true;
        autoEnable = false;
        image = ./default_wp.png;
        polarity = "dark";

        homeManagerIntegration.followSystem = false;
      };
    };
  };
}
