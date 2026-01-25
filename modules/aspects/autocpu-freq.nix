{ den, ... }:
{
  # NOTE: Requires adding auto-cpufreq input to flake.nix:
  # auto-cpufreq.url = "github:AdnanHodzic/auto-cpufreq/v2.6.0";
  # auto-cpufreq.inputs.nixpkgs.follows = "nixpkgs";
  den.aspects."autocpu-freq" = {
    nixos = { lib, inputs, ... }: {
      imports = [
        inputs.auto-cpufreq.nixosModules.default
      ];
      programs.auto-cpufreq.enable = true;
      services.power-profiles-daemon.enable = lib.mkForce false;
      services.tlp.enable = lib.mkForce false;
    };
  };
}
