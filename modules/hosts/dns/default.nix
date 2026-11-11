{ den, ... }:
{
  den.aspects.dns = {
    includes = [
      den._.hostname
      den.aspects.microvm-guest
      den.aspects.technitium
    ];

    nixos.system.stateVersion = "26.05";
  };
}
