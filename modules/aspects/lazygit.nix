{ den, ... }:
{
  den.aspects.lazygit = {
    homeManager = { pkgs, config, ... }: {
      programs.lazygit = {
        enable = true;
        package = pkgs.lazygit;
        enableZshIntegration = true;
        enableBashIntegration = true;

        settings = {
          gui = {
            nerdFontsVersion = 3;
          };
        };
      };
    };
  };
}
