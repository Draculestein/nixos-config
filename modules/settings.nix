{ den, lib, ... }:
{
  # Aspects declare typed tunables in `settings`; hosts set them under
  # `den.hosts.<system>.<name>.settings.<aspect path>`, and class modules
  # read them as `host.settings.<aspect path>`.
  den.reservedKeys = [ "settings" ];

  den.schema.host.imports = [
    {
      options.settings = lib.mkOption {
        type = import ./_settings-type.nix { inherit den lib; };
        default = { };
        description = "Per-aspect typed settings";
      };
    }
  ];
}
