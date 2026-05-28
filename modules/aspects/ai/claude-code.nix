{ den, ... }: {
  den.aspects.ai.provides.claude-code = {
    homeManager = {
      programs.claude-code = {
        enable = true;
        settings = {
          enabledPlugins = { };
          extraKnownMarketplaces = { };
          effortLevel = "high";
        };
      };
    };
  };
}
