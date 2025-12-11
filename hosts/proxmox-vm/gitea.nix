{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."git.developing.company" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3001/";
      };

      # virtualHosts."mygitinstance.com" = {
      #   forceSSL = true;
      #   useACMEHost = "mygitinstance.com";
      #   locations."/" = {
      #     proxyPass = "http://unix:/run/gitea/gitea.sock";
      # };
      # };
      # ... other virtual hosts ...
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "eu+cloudflare@andrebrandao.dev";
    certs."developing.company" = {
      domain = "*.developing.company";
      # group = "nginx";
      dnsProvider = "cloudflare";
      dnsPropagationCheck = true;
      # credentialsFile = "/var/credentials/aws_certbot";
      environmentFile = "/home/admin/cloudflare";
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "gitea" ];
    identMap = ''
      # ArbitraryMapName systemUser DBUser
      superuser_map      root      postgres
      superuser_map      postgres  postgres
      # Let other names login as themselves
      superuser_map      /^(.*)$   \1
    '';
  };

  services.gitea = {
    enable = true;
    appName = "Developing git";
    database = {
      type = "postgres";
    };
    settings = {
      # server.PROTOCOL = "http+unix";
      server.ROOT_URL = "https://git.developing.company/";
      server.DOMAIN = "git.developing.company";
      server.HTTP_PORT = 3001;
    };
    # httpPort = 3001;
  };
}
