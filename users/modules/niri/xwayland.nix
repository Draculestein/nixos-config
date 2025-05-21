{ config, lib, pkgs, ... }: {
  home.packages = [ pkgs.xwayland-satellite-unstable ];

  # XWayland
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland outside your Wayland";
      BindsTo = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };

    Service = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = "${pkgs.xwayland-satellite-unstable}/bin/xwayland-satellite";
      StandardOutput = "journal";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

}
