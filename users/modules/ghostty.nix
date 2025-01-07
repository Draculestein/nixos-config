{ config, lib, pkgs, inputs, ... }: {
  home.packages = [
    inputs.ghostty.x86_64-linux.default
  ];
}
