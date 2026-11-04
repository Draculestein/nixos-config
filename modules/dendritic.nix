{ inputs, lib, ... }:
{
  flake-file.inputs.flake-file.url = lib.mkDefault "github:denful/flake-file";
  flake-file.inputs.den.url = "github:denful/den?ref=v0.19.0";
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  debug = true;
}
