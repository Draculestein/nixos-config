{ den, ... }:
{
  den.aspects.niri.provides.idle = {
    homeManager = { ... }: {
      custom.hypridle.configs.niri = {
        afterSleepCmd = "niri msg action power-on-monitors";
        dpmsOffCmd = "niri msg action power-off-monitors";
        dpmsOnCmd = "niri msg action power-on-monitors";
        compositorService = "niri.service";
      };
    };
  };
}
