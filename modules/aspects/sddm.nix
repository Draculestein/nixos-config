{ den, ... }:
{
  den.aspects.sddm = {
    nixos = { config, lib, pkgs, ... }: {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
