{ config, inputs, ... }:

let
  version = "1.37.1";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.secrets."vaultwarden-domain" = {
    restartUnits = [ "podman-vaultwarden.service" ];
  };
  sops.secrets."vaultwarden-admin-token" = {
    restartUnits = [ "podman-vaultwarden.service" ];
  };

  # vaultwarden mounts its routes under the path component of DOMAIN, so the
  # container must restart whenever this template changes
  sops.templates."vaultwarden.env" = {
    restartUnits = [ "podman-vaultwarden.service" ];
    content = ''
      DOMAIN=https://${config.sops.placeholder."vaultwarden-domain"}
      ADMIN_TOKEN=${config.sops.placeholder."vaultwarden-admin-token"}
    '';
  };

  virtualisation.oci-containers.containers."vaultwarden" = {
    image = "vaultwarden/server:${version}";
    autoStart = true;
    ports = [
      "8081:80/tcp"
    ];
    volumes = [
      "/srv/data/vaultwarden:/data"
    ];
    environmentFiles = [
      config.sops.templates."vaultwarden.env".path
    ];
  };

  services.traefik.dynamicConfigOptions.http = {
    routers.vaultwarden = {
      # served at the root; more specific routers (/vault, /traefik) win on
      # traefik's default rule-length priority
      rule = "Host(`vault.fable-company.ts.net`)";
      service = "vaultwarden";
      tls = {
        certResolver = "vpnresolver";
      };
    };
    services.vaultwarden = {
      loadBalancer = {
        servers = [
          {
            url = "http://localhost:8081";
          }
        ];

      };
    };
  };
}
