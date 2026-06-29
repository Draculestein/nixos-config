{ den, inputs, ... }:
{
  flake-file.inputs = {
    llm-agents.url = "github:numtide/llm-agents.nix";
    omp-nix.url = "git+https://git.molez.org/mandlm/omp-nix";
  };

  den.aspects.ai.provides.pi = {
    homeManager = { pkgs, ... }: {
      imports = [ inputs.omp-nix.homeManagerModules.omp ];
      oh-my-pi = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.omp;
      };
    };
  };
}
