{ den, ... }:
{
  den.aspects.heimdall-admin = { user, ... }: {
    nixos = { ... }: {
      users.users.${user.userName} = {
        uid = 1000;
        extraGroups = [
          "incus-admin"
          "wheel"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBptV0OoHkw9GkXw5pyuO7lWtXjvEnpbjPtaeIZUtOWX"
        ];
      };

      security.sudo.wheelNeedsPassword = false;
    };
  };
}
