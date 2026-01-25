{ den, ... }:
{
  den.aspects.ollama = {
    nixos = { config, lib, pkgs, ... }: {
      services.ollama = {
        enable = true;
        acceleration = "cuda";
      };
    };
  };
}
