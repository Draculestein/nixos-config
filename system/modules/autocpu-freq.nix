{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];

  programs.auto-cpufreq.enable = true;
  services.power-profiles-daemon.enable = lib.mkForce false;
  services.tlp.enable = lib.mkForce false;

}
