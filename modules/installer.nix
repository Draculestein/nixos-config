{ inputs, ... }:
{
  # Live media is independent of installed hosts, disks, and secrets.
  flake.nixosConfigurations.installer = inputs.nixpkgs-stable.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      (
        { lib, modulesPath, ... }:
        {
          imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

          networking.hostName = "nixos-installer";
          networking.networkmanager.enable = true;
          hardware.enableRedistributableFirmware = true;

          # Public live-media password: nixos. Never reuse it on an installed host.
          users.users.nixos.initialHashedPassword = lib.mkForce
            "$6$v5IbdIuxLelV57uk$otcFd4wEIWMrGHesoecwzqe.8JpVmt1b1NPpf3ctr42ipxrp/07aJ.RkC2N0YN6jTuPpTo1QSAJ7zgabyOAxe.";

          services.openssh = {
            enable = true;
            openFirewall = true;
            settings = {
              AllowUsers = [ "nixos" "root" ];
              PasswordAuthentication = true;
              KbdInteractiveAuthentication = false;
              PermitRootLogin = "prohibit-password";
            };
          };

          nix.settings.experimental-features = [ "nix-command" "flakes" ];
        }
      )
    ];
  };

  flake.packages.x86_64-linux.installer =
    inputs.self.nixosConfigurations.installer.config.system.build.isoImage;
}
