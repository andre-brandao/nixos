{
  config,
  lib,
  pkgs,
  settings,
  ...
}:
let
  domain = "git.fable-company.ts.net";
  httpPort = 3001;
in
{
  sops.secrets."forgejo/runner_token" = { };

  services.forgejo = {
    enable = true;
    stateDir = "/srv/forgejo";
    lfs.enable = true;
    database.type = "sqlite3";
    settings = {
      server = {
        DOMAIN = domain;
        ROOT_URL = "https://${domain}/";
        HTTP_PORT = httpPort;
        SSH_PORT = lib.head config.services.openssh.ports;
        OFFLINE_MODE = true;
      };
      service.DISABLE_REGISTRATION = true;
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      ui = {
        DEFAULT_THEME = "custom";
        THEMES = "forgejo-auto,forgejo-dark,forgejo-light,custom";
      };
    };
  };

  systemd.tmpfiles.rules =
    let
      cfg = config.services.forgejo;
    in
    [
      "d '${cfg.customDir}/templates' - forgejo forgejo - -"
      "d '${cfg.customDir}/public/assets/css' - forgejo forgejo - -"
      "C+ '${cfg.customDir}/public/assets/css/theme-custom.css' - forgejo forgejo - ${../git-theme/theme-custom.css}"
      "C+ '${cfg.customDir}/templates/home.tmpl' - forgejo forgejo - ${../git-theme/home.tmpl}"
    ];

  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.default = {
      enable = true;
      name = "git";
      url = "https://${domain}";
      # tokenFile must contain: TOKEN=<secret>
      tokenFile = config.sops.secrets."forgejo/runner_token".path;
      labels = [
        "ubuntu-latest:docker://node:16-bullseye"
        "ubuntu-22.04:docker://node:16-bullseye"
        "ubuntu-20.04:docker://node:16-bullseye"
        "ubuntu-18.04:docker://node:16-buster"
        ## optionally provide native execution on the host:
        # "native:host"
      ];
    };
  };

  users.users.git = {
    isSystemUser = true;
    useDefaultShell = true;
    group = "git";
    extraGroups = [ "forgejo" ];
    home = config.services.forgejo.stateDir;
    openssh.authorizedKeys.keys = settings.sshPublicKeys;
  };
  users.groups.git = { };

  # reverse proxy
  services.traefik.dynamicConfigOptions.http = {
    routers.git = {
      rule = "Host(`${domain}`)";
      service = "git";
      tls.certResolver = "vpnresolver";
    };
    services.git.loadBalancer.servers = [
      { url = "http://localhost:${toString httpPort}"; }
    ];
  };
}
