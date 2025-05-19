{ config, lib, pkgs, inputs, ... }: {
  services.swww = {
    enable = true;
    package = inputs.swww.packages.${pkgs.system}.swww;
  };
}
