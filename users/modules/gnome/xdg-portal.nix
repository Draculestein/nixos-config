{ config, lib, pkgs, ... }:
{
  xdg.portal = {
    config = {
      gnome = {
        default = [
          "gnome"
        ];
      };
    };
  };
}
