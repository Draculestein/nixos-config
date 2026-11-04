{ den, ... }:
{
  den.aspects.openssh-server.nixos = {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        AllowUsers = [ "albertjul" ];
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
