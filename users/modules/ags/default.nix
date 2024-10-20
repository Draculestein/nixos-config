{ inputs, pkgs, ... }:
{
  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = false;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = null; # Using the default ags path ($XDG_HOME/.config/ags)

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk_6_0
      accountsservice
    ];
  };
}