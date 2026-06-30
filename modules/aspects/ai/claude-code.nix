{ den, inputs, ... }: {
  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";

  den.aspects.ai.provides.claude-code = {
    includes = [ (den.batteries.unfree [ "claude-code" ]) ];

    homeManager = { pkgs, ... }: {
      programs.claude-code = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;
      };
    };
  };
}
