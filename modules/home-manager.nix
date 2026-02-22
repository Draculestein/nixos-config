{ den, ... }:
{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager/master";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.default.includes = [
    den._.home-manager
    den.aspects.homeManager
    den._.define-user
    den._.self'
    den._.inputs'
  ];

  den.ctx.hm-host.nixos.home-manager.useGlobalPkgs = true;

  den.aspects.homeManager.homeManager = { config, ... }: {
    targets.genericLinux.enable = true;
    xdg.mime.enable = true;
    xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

    programs.bash.enable = true;
    programs.vim.enable = true;

    # Let home-manager install and manage itself
    programs.home-manager.enable = true;
  };
}
