{ config, lib, pkgs, inputs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = false;
    image = ./default_wp.png;
    polarity = "dark";

    homeManagerIntegration.followSystem = false;
  };

  home-manager.sharedModules = [
    {
      stylix.enable = true;
    }
  ];
}
