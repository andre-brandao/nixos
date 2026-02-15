{ config, inputs, ... }:

let
  version = "1.35.1";
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

  sops.templates."vaultwarden.env".content = ''
    DOMAIN=https://${config.sops.placeholder."vaultwarden-domain"}/warden
    ADMIN_TOKEN=${config.sops.placeholder."vaultwarden-admin-token"}
  '';

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
      rule = "Host(`vault.fable-company.ts.net`) && PathPrefix(`/warden`)";
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
