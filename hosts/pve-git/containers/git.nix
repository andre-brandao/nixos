{ config, ... }:
{
  # services.nginx.virtualHosts."git.my-domain.tld" = {
  #   enableACME = true;
  #   forceSSL = true;
  #   locations."/" = {
  #     proxyPass = "http://localhost:3001/";
  #   };
  # };

  services.postgresql = {
    ensureDatabases = [ config.services.gitea.user ];
    ensureUsers = [
      {
        name = config.services.gitea.database.user;
        ensurePermissions."DATABASE ${config.services.gitea.database.name}" = "ALL PRIVILEGES";
      }
    ];
  };

  sops.secrets."postgres/gitea_dbpass" = {
    owner = config.services.gitea.user;
  };

  services.gitea = {
    enable = true;
    appName = "My awesome Gitea server"; # Give the site a name
    database = {
      type = "postgres";
      passwordFile = config.sops.secrets."postgres/gitea_dbpass".path;
    };
    domain = "git.fable-company.ts.net";
    rootUrl = "https://git.fable-company.ts.net";
    httpPort = 3001;
  };
  services.traefik.dynamicConfigOptions.http = {
    routers.git = {
      rule = "Host(`git.fable-company.ts.net`)";
      service = "git";
      tls = {
        certResolver = "vpnresolver";
      };
    };
    services.git = {
      loadBalancer = {
        servers = [
          {
            url = "http://localhost:3001";
          }
        ];
      };
    };
  };
}
