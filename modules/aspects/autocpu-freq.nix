{ den, inputs, ... }:
{
  flake-file.inputs."autocpu-freq" = {
    url = "github:AdnanHodzic/auto-cpufreq";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects."autocpu-freq" = {
    nixos = { lib, ... }: {
      imports = [
        inputs.auto-cpufreq.nixosModules.default
      ];
      programs.auto-cpufreq.enable = true;
      services.power-profiles-daemon.enable = lib.mkForce false;
      services.tlp.enable = lib.mkForce false;
    };
  };
}
