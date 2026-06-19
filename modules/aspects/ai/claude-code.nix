{ den, ... }: {
  den.aspects.ai.provides.claude-code = {
    includes = [ (den.batteries.unfree [ "claude-code" ]) ];

    homeManager = {
      programs.claude-code = {
        enable = true;
      };
    };
  };
}
