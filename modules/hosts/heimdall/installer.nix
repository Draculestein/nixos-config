{ inputs, ... }:
{
  # Keep live-media networking and users separate from the installed host.
  flake.nixosConfigurations.heimdall-installer = inputs.nixpkgs-stable.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      (
        { lib, modulesPath, ... }:
        {
          imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

          networking.hostName = "heimdall-installer";
          networking.networkmanager.enable = true;
          hardware.enableRedistributableFirmware = true;

          # Reuse the installed admin's public keys; never embed a private key.
          users.users.nixos.openssh.authorizedKeys.keys =
            inputs.self.nixosConfigurations.heimdall.config.users.users.albertjul.openssh.authorizedKeys.keys;

          # Public live-media password: nixos. Never reuse it on an installed host.
          users.users.nixos.initialHashedPassword = lib.mkForce
            "$6$v5IbdIuxLelV57uk$otcFd4wEIWMrGHesoecwzqe.8JpVmt1b1NPpf3ctr42ipxrp/07aJ.RkC2N0YN6jTuPpTo1QSAJ7zgabyOAxe.";

          services.openssh = {
            enable = true;
            openFirewall = true;
            settings = {
              AllowUsers = [ "nixos" ];
              PasswordAuthentication = true;
              KbdInteractiveAuthentication = false;
              PermitRootLogin = "no";
            };
          };

          nix.settings.experimental-features = [ "nix-command" "flakes" ];
        }
      )
    ];
  };

  flake.packages.x86_64-linux.heimdall-installer =
    inputs.self.nixosConfigurations.heimdall-installer.config.system.build.isoImage;
}
