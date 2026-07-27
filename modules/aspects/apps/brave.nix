{ den, ... }:
{
  den.aspects.brave = {
    # nixpkgs regression (2026-07-24, "brave, brave-origin: extract shared
    # builder"): the flavor refactor applies the second arg set outside
    # `makeOverridable`, so top-level `brave` lost `.override`. home-manager's
    # chromium module builds `finalPackage` via `package.override
    # { commandLineArgs = …; }`, which then errors with "attribute 'override'
    # missing". Re-introduce an overridable `commandLineArgs` layer the way
    # firefox's wrapper.nix does (`lib.makeOverridable wrapper`). Drop once
    # upstream restores `brave.override`.
    nixos = { pkgs, lib, ... }: {
      nixpkgs.overlays = [
        (final: prev: {
          brave = lib.makeOverridable (
            { commandLineArgs ? "", ... }:
            if commandLineArgs == "" then
              prev.brave
            else
              final.symlinkJoin {
                name = "brave-${prev.brave.version}";
                paths = [ prev.brave ];
                nativeBuildInputs = [ final.makeWrapper ];
                postBuild = ''
                  wrapProgram $out/bin/brave --add-flags "${commandLineArgs}"
                '';
                inherit (prev.brave) meta;
              }
          ) { };
        })
      ];
    };

    homeManager = { config, lib, pkgs, ... }: {
      programs.brave = {
        enable = true;
        package = pkgs.brave;

        commandLineArgs = [
          "--password-store=detect"
          "--enable-features=AcceleratedVideoEncoder,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL,VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,TouchpadOverscrollHistoryNavigation"
          "--ozone-platform-hint=auto"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
        ];
      };
    };
  };
}
