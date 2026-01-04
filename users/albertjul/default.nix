{ inputs, ... }:
let
  username = "albertjul";
in
{
  flake.modules.nixos."${username}" = { pkgs, ... }: {
    users.users.albertjul = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "podman" "gamemode" "libvirtd" "video" "dialout" "scanner" "lp" ];
      packages = [ ]; # Apps are handled by home-manager
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
    environment.shells = with pkgs; [
      zsh
      bash
    ];
  };
}
