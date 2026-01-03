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
      api_addr     = "https://${hostname}"
      disable_clustering = true
      ui           = true
    '';
    # tlsCertFile = "${sslCert}";
    # tlsKeyFile = "${sslCertKey}";
  };

  services.traefik.dynamicConfigOptions.http = {
    routers.vault = {
      rule = "Host(`${hostname}`)";
      service = "vault";
      # middlewares = [ "vault-stripprefix" ];
      tls = {
        certResolver = "vpnresolver";
      };
    };
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
