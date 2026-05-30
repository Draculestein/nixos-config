{ den, ... }:
{
  den.aspects.gdm = {
    nixos = { config, lib, pkgs, ... }: {
      services.displayManager.gdm.enable = true;
      environment.sessionVariables.XDG_DATA_DIRS = [ "${pkgs.gdm}/share" ];
      programs.sway.enable = true;
      services.displayManager.gdm.settings.debug.Enable = true;

      # add pkgs.gnome-session to the greeter's PATH
      security.pam.services.gdm-launch-environment.rules.session.gnome-session-path = {
        inherit (config.security.pam.services.gdm-launch-environment.rules.session.env) control modulePath;
        order = config.security.pam.services.gdm-launch-environment.rules.session.env.order + 50;
        settings = {
          conffile =
            let
              envfile = pkgs.writeText "gnome-session-path.env" ''
                PATH   DEFAULT="''${PATH}:${pkgs.gnome-session}/bin"
              '';
            in
            "${envfile}";
          readenv = 0;
        };
      };
    };
  };
}
