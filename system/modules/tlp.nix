{ config, lib, pkgs, ... }:
{
  services.power-profiles-daemon.enable = lib.mkForce false;
  services.tlp.enable = true;
  services.tlp.settings = {
    DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
    RUNTIME_PM_ON_AC = "on";
    RUNTIME_PM_ON_BAT = "auto";

    # CPU Settings
    CPU_DRIVER_OPMODE_ON_AC = "active";
    CPU_DRIVER_OPMODE_ON_BAT = "active";

    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
  };
}
