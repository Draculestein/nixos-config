{ inputs, lib, ... }:
{
  flake-file.inputs.flake-file.url = lib.mkDefault "github:denful/flake-file";
  flake-file.inputs.den.url = "github:vic/den?ref=v0.18.0";
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  debug = true;
}
