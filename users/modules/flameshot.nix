{config, lib, pkgs, ... }:
{
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override {
      enableWlrSupport = true;
      enableMonochromeIcon = true;
    };
  };
}