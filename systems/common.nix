{ inputs, ... }:
{
  flake.modules.nixos.common = { pkgs, ... }: {
    # Force Wayland on Electron apps
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.shells = with pkgs; [
      zsh
      bash
    ];

    environment.systemPackages = with pkgs; [
      killall
      btop
      vim
      wget
      git
      tree
      btop
      pciutils
      usbutils
      nix-output-monitor
      nvd
    ];

    programs.zsh.enable = true;
    programs.dconf.enable = true;

    services.gvfs.enable = true;
    services.gnome.localsearch.enable = true;
  };
}
