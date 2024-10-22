{ inputs, pkgs, ... }:
{
  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    pywal
    sassc
    (python311.withPackages (p: [
      p.material-color-utilities
      p.pywayland
    ]))
    ydotool
  ];

  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = null; # Using the default ags path ($XDG_HOME/.config/ags)

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk_6_0
      accountsservice
      gtksourceview4
      python311Packages.material-color-utilities
      python311Packages.pywayland
      pywal
      sassc
      webp-pixbuf-loader
      ydotool
    ];
  };
}
