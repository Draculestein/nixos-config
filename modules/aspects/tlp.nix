{ den, ... }:
{
  den.aspects.tlp = {
    nixos = { config, lib, pkgs, ... }: {
      services.power-profiles-daemon.enable = lib.mkForce false;
      services.tlp.enable = true;
      services.tlp.settings = {
        USB_AUTOSUSPEND = 0;
        USB_EXCLUDE_BTUSB = 1;
        TLP_DEFAULT_MODE = "BAT";
        RUNTIME_PM_DRIVER_DENYLIST = "mei_me nouveau xhci_hcd amdxdna";
        RUNTIME_PM_ON_AC = "auto";
        RUNTIME_PM_ENABLE = "64:00.0 64:00.1";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
      };
    };
  };
}
