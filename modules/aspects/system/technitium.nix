{ den, lib, ... }:
let
  name = "technitium";
  secretsDir = "/var/lib/microvms/${name}/secrets";
  adminPasswordCredential = "technitium-admin-password";
  webPort = 5380;
in
{
  den.aspects.technitium = {
    includes = [ den.aspects.microvm-host ];

    nixos =
      { pkgs, ... }:
      {
        # SERVERS VLAN.
        lanMicrovms.${name} = {
          vlan = 50;
          address = "10.0.50.53";
          gateway = "10.0.50.1";
          nameservers = [ "127.0.0.1" ];
          mac = "02:00:00:00:50:53";
          mem = 1024;
          varSize = 4096;
          credentialFiles.${adminPasswordCredential} = "${secretsDir}/admin-password";
        };

        microvm.vms.${name}.config = {
          # resolved's 127.0.0.53/54 listeners block Technitium's TCP bind on 0.0.0.0:53.
          services.resolved.enable = false;

          services.technitium-dns-server = {
            enable = true;
            openFirewall = true;
            firewallTCPPorts = [
              53
              webPort
            ];
          };

          # Technitium reads these only on first start, when no dns.config
          # exists yet; afterwards the web UI owns the settings on /var.
          systemd.services.technitium-dns-server = {
            environment = {
              DNS_SERVER_WEB_SERVICE_HTTP_PORT = toString webPort;
              DNS_SERVER_RECURSION = "AllowOnlyForPrivateNetworks";
              # Encrypted forwarding; the bracketed IPs avoid a bootstrap lookup.
              DNS_SERVER_FORWARDERS = lib.concatStringsSep "," [
                "https://cloudflare-dns.com/dns-query (1.1.1.1)"
                "https://dns.quad9.net/dns-query (9.9.9.9)"
              ];
              DNS_SERVER_FORWARDER_PROTOCOL = "Https";
              DNS_SERVER_ADMIN_PASSWORD_FILE = "%d/${adminPasswordCredential}";
            };
            # An unreadable password file makes Technitium fall back to "admin".
            serviceConfig.LoadCredential = [ adminPasswordCredential ];
          };
        };

        # qemu reads credential files as the `microvm` user at VM start.
        systemd.services."${name}-secrets" = {
          description = "Generate secrets for MicroVM '${name}'";
          before = [ "microvm@${name}.service" ];
          requiredBy = [ "microvm@${name}.service" ];
          path = [
            pkgs.coreutils
            pkgs.openssl
          ];
          script = ''
            install -d -m 0700 -o microvm ${secretsDir}
            umask 0077
            file=${secretsDir}/admin-password
            if [ ! -s "$file" ]; then
              openssl rand -base64 24 > "$file"
            fi
            chown microvm "$file"
            chmod 0400 "$file"
          '';
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };
        };
      };
  };
}
