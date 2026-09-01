{ pkgs, ... }:
let
  hostname = "vault.fable-company.ts.net";
in
{
  services.vault = {
    enable = true;
    package = pkgs.vault-bin;
    address = "[::]:8200";
    storageBackend = "file";
    storagePath = "/var/lib/vault";
    extraConfig = ''
      api_addr     = "https://${hostname}/vault"
      disable_clustering = true
      ui           = true
    '';
    # tlsCertFile = "${sslCert}";
    # tlsKeyFile = "${sslCertKey}";
  };

  services.traefik.dynamicConfigOptions.http = {
    routers.vault = {
      rule = "Host(`${hostname}`) && PathPrefix(`/vault`)";
      service = "vault";
      middlewares = [ "vault-stripprefix" ];
      tls = {
        certResolver = "vpnresolver";
      };
    };
    middlewares.vault-stripprefix.stripPrefix.prefixes = [ "/vault" ];
    services.vault = {
      loadBalancer = {
        servers = [
          {
            url = "http://localhost:8200";
          }
        ];

      };
    };
  };

}
