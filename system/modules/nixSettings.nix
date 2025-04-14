{ config, lib, pkgs, inputs, ... }: 
{ 

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs-unstable}" ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
