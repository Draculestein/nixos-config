{ den, ... }: {
  den.aspects.albertjul = {
    includes = [
      den.aspects.code-dev
    ];

    nixos = { pkgs, ... }: {
      users.users.albertjul = {
        isNormalUser = true;
        uid = 1000;
        extraGroups = [ "wheel" "podman" "gamemode" "libvirtd" "video" "dialout" "scanner" "lp" ]; # Enable ‘sudo’ for the user.
        packages = [ ]; # Apps are handled by home-manager
        shell = pkgs.zsh;
      };
    };
  };
}
