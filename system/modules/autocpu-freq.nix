{config, lib, pkgs, inputs, ...}:
{
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];

  services.auto-cpufreq.enable = true;
}