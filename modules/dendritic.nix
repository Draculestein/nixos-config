{ inputs, lib, ... }:
{
  flake-file.inputs.flake-file.url = lib.mkDefault "github:vic/flake-file";
  flake-file.inputs.den.url = "github:vic/den?ref=v0.16.0";
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  debug = true;
}
