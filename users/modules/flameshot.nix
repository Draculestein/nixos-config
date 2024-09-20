{config, lib, pkgs, ... }:
{
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override {
      enabaleWlrSupport = true;
      enableMonochromeIcon = true;
    };
  };
}