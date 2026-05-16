{ den, ... }:
{
  den.aspects.nh.nixos = { pkgs, ... }: {
    programs.nh = {
      enable = true;
      flake = "/home/albertjul/.dotfiles";
    };
  };
}
