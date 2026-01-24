{ config, lib, pkgs, inputs, ... }: {
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    iwmenu
    bzmenu
  ];

  programs.walker = {
    enable = true;
    runAsService = true;
  };
}
