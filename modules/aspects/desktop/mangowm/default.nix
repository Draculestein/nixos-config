{ den, inputs, ... }:
{
  flake-file.inputs = {
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
    };

  };

  den.aspects.mangowm = {
    nixos = {
      imports = [
        inputs.mango.nixosModules.mango
      ];

      programs.mango.enable = true;
    };

    homeManager = { ... }: {
      imports = [
        inputs.mango.hmModules.mango
      ];

      wayland.windowManager.mango = {
        enable = true;
      };
    };
  };
}
