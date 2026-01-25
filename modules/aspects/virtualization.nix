{ den, ... }:
{
  den.aspects.virtualization = {
    nixos = { config, lib, pkgs, ... }: {
      virtualisation.containers.enable = true;
      virtualisation = {
        docker = {
          enable = true;
          storageDriver = "btrfs";

          rootless = {
            enable = true;
            setSocketVariable = true;
          };
        };

        podman = {
          enable = true;
          defaultNetwork.settings.dns_enabled = true;
        };

        libvirtd = {
          enable = true;

          qemu = {
            swtpm.enable = true;
          };
        };

        spiceUSBRedirection.enable = true;
      };

      users.extraGroups.docker.members = [ "albertjul" ];

      environment.systemPackages = with pkgs; [
        dive
        podman-tui
        docker-compose
        qemu
        gnome-boxes
      ];

      programs.virt-manager.enable = true;
    };
  };
}
