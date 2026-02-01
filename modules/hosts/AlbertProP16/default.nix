{ den, ... }:
{
  den.aspects.AlbertProP16.includes = [
    # Hardware
    den.aspects.asus
    den.aspects.zswap
    den.aspects.blueman

    # Display Manager and DE
    den.aspects.gdm
    den.aspects.gnome
    den.aspects.gnome-polkit

    # Software & 
    den.aspects.power-profiles-daemon
    den.aspects.common
    den.aspects.fonts
    den.aspects.printing
    den.aspects.logitech
    den.aspects.nh
    den.aspects."nix-settings"
    den.aspects.virtualization
    den.aspects.restic
    den.aspects.sops
    den.aspects.sound
    den.aspects.steam
    den.aspects.flatpak
    den.aspects.ssh
    den.aspects.stylix
    den.aspects.xbox-controller
  ];
}
