{
  config,
  lib,
  settings,
  ...
}:
{
  # services.nginx.virtualHosts."git.my-domain.tld" = {
  #   enableACME = true;
  #   forceSSL = true;
  #   locations."/" = {
  #     proxyPass = "http://localhost:3001/";
  #   };
  # };

  # services.postgresql = {
  #   ensureDatabases = [ config.services.gitea.user ];
  #   ensureUsers = [
  #     {
  #       name = config.services.gitea.database.user;
  #       # ensurePermissions."DATABASE ${config.services.gitea.database.name}" = "ALL PRIVILEGES";
  #     }
  #   ];
  # };

  # sops.secrets."postgres/gitea_dbpass" = {
  #   owner = config.services.gitea.user;
  # };

  services.gitea = rec {
    enable = true;
    domain = "git.fable-company.ts.net";
    appName = "My awesome Gitea server"; # Give the site a name
    rootUrl = "https://${domain}";
    httpPort = 3001;
    stateDir = "/srv/gitea";
    user = "git";
    database = {
      # type = "postgres";
      # passwordFile = config.sops.secrets."postgres/gitea_dbpass".path;
      type = "sqlite3";
      inherit user;
      path = "${stateDir}/gitea.db";
    };
    ssh = {
      clonePort = lib.head config.services.openssh.ports;
    };
    lfs = {
      enable = true;
      contentDir = "${stateDir}/lfs";
    };
    cookieSecure = true;
    settings = {
      server = {
        SSH_USER = "git";
        SSH_DOMAIN = "git.${domain}";
        # SSH_TRUSTED_USER_CA_KEYS = lib.concatStringsSep "," [
        #   # (builtins.readFile "${inputs.ssh}/ca.pub")
        # ];
        OFFLINE_MODE = true;
      };
    };
    log.rootPath = "${stateDir}/log";
  };

  users.users.git = {
    isSystemUser = true;
    useDefaultShell = true;
    group = "git";
    extraGroups = [ "gitea" ];
    home = config.services.gitea.stateDir;
    openssh.authorizedKeys.keys = settings.sshPublicKeys;
  };
  users.groups.git = { };

  # reverse proxy
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
