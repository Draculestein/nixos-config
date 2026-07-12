{ den, ... }:
{
  den.aspects.gdm = {
    nixos = {
      services.displayManager.gdm.enable = true;
    };
  };
}
