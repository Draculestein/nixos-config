{ den, ... }:
{
  den.aspects.kitty = {
    homeManager = { ... }: {
      programs.kitty = {
        enable = true;
        enableGitIntegration = true;
        shellIntegration = {
          enableZshIntegration = true;
        };
      };
    };
  };
}
