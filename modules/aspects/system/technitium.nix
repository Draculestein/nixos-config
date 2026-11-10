{ lib, ... }:
{
  # Technitium DNS Server on whichever host includes it: a microVM guest,
  # a VPS or bare metal.
  den.aspects.technitium = {
    settings = {
      adminPasswordFile = lib.mkOption {
        type = lib.types.str;
        description = ''
          File holding the initial `admin` password, read on first start.
          On a microVM guest pass a SOPS secret through
          `microvm-guest.secrets`: `/run/credentials/@system/<name>`.
        '';
      };
      webPort = lib.mkOption {
        type = lib.types.port;
        default = 5380;
        description = "HTTP port of the web UI and API.";
      };
      forwarders = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        # Bracketed IPs avoid a bootstrap lookup.
        default = [
          "https://cloudflare-dns.com/dns-query (1.1.1.1)"
          "https://dns.quad9.net/dns-query (9.9.9.9)"
        ];
        description = "Initial upstream forwarders; empty for full recursion.";
      };
      forwarderProtocol = lib.mkOption {
        type = lib.types.enum [
          "Udp"
          "Tcp"
          "Tls"
          "Https"
          "Quic"
        ];
        default = "Https";
      };
      recursion = lib.mkOption {
        type = lib.types.enum [
          "Deny"
          "Allow"
          "AllowOnlyForPrivateNetworks"
          "UseSpecifiedNetworkACL"
        ];
        default = "AllowOnlyForPrivateNetworks";
      };
      openFirewall = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Open DNS (53) and the web UI port in the host firewall.";
      };
    };

    nixos =
      { host, ... }:
      let
        cfg = host.settings.technitium;
      in
      {
        services.technitium-dns-server = {
          enable = true;
          inherit (cfg) openFirewall;
          firewallTCPPorts = [
            53
            cfg.webPort
          ];
        };

        # resolved's 127.0.0.53/54 listeners block Technitium's TCP bind on
        # 0.0.0.0:53; the host resolves through Technitium instead.
        services.resolved.enable = false;
        networking.nameservers = lib.mkDefault [ "127.0.0.1" ];

        # Technitium reads these only on first start, when no dns.config
        # exists yet; afterwards the web UI owns the settings in /var.
        systemd.services.technitium-dns-server = {
          environment = {
            DNS_SERVER_WEB_SERVICE_HTTP_PORT = toString cfg.webPort;
            DNS_SERVER_RECURSION = cfg.recursion;
            DNS_SERVER_FORWARDERS = lib.concatStringsSep "," cfg.forwarders;
            DNS_SERVER_FORWARDER_PROTOCOL = cfg.forwarderProtocol;
            DNS_SERVER_ADMIN_PASSWORD_FILE = "%d/admin-password";
          };
          # An unreadable password file makes Technitium fall back to "admin".
          serviceConfig.LoadCredential = [ "admin-password:${cfg.adminPasswordFile}" ];
        };
      };
  };
}
