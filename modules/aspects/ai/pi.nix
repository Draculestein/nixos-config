{ den, inputs, ... }:
{
  flake-file.inputs = {
    llm-agents.url = "github:numtide/llm-agents.nix";
    omp-nix.url = "git+https://git.molez.org/mandlm/omp-nix";
  };

  den.aspects.ai.provides.pi = {
    nixos = {
      nix.settings = {
        extra-substituters = [ "https://cache.numtide.com" ];
        extra-trusted-public-keys = [
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
      };
    };


    homeManager = { pkgs, ... }: {
      # imports = [ inputs.omp-nix.homeManagerModules.omp ];
      # oh-my-pi = {
      #   enable = true;
      #   package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.omp;
      # };

      home.packages = [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.omp
      ];
    };
  };
}
