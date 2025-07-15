{ config, lib, pkgs, inputs, ... }: {
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  nix.settings = {
    substituters = [ "https://walker-git.cachix.org" ];
    trusted-public-keys = [ "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM=" ];
  };

  home.packages = with pkgs; [
    iwmenu
    bzmenu
  ];

  programs.walker = {
    enable = true;
    runAsService = true;
  };
}
