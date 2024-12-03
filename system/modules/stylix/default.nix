{config, lib, pkgs, inputs, ...}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    image = ./default_wp.png;
  };
}