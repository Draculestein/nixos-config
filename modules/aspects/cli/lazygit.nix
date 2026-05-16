{ den, ... }:
{
  den.aspects.lazygit = {
    homeManager = { pkgs, config, lib, ... }: {
      programs.lazygit = {
        enable = true;
        package = pkgs.lazygit;
        enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
        enableBashIntegration = lib.mkIf config.programs.bash.enable true;

        settings = {
          gui = {
            nerdFontsVersion = 3;
          };
        };
      };
    };
  };
}
