{ den, inputs, ... }:
{
  # brave was removed from nixpkgs and re-added in NixOS/nixpkgs#584534, which has only
  # reached nixos-unstable-small so far. Drop this input once it lands in nixos-unstable.
  flake-file.inputs.nixpkgs-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";

  den.aspects.brave = {
    homeManager = { config, lib, pkgs, ... }: {
      programs.brave = {
        enable = true;
        package = inputs.nixpkgs-unstable-small.legacyPackages.${pkgs.stdenv.hostPlatform.system}.brave;

        commandLineArgs = [
          "--password-store=detect"
          "--enable-features=AcceleratedVideoEncoder,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL,VaapiVideoDecoder,VaapiIgnoreDriverChecks,TouchpadOverscrollHistoryNavigation"
          "--ozone-platform-hint=auto"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
        ];
      };
    };
  };
}
