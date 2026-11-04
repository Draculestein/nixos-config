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
        # Provision ~/.ssh/authorized_keys on the host, not in the Nix store.
      };

      security.sudo.wheelNeedsPassword = false;
    };
  };
}
