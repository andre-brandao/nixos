{ config, inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.secrets."vaultwarden-domain" = { };
  sops.templates."vaultwarden.env".content = ''
    DOMAIN=https://${config.sops.placeholder."vaultwarden-domain"}
  '';

  virtualisation.oci-containers.containers."vaultwarden" = {
    image = "vaultwarden/server";
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
    middlewares.vaultwarden-stripprefix.stripprefix = {
      prefixes = [ "/warden" ];
      forceSlash = true;
    };
    routers.vaultwarden = {
      rule = "Host(`vault.fable-company.ts.net`) && PathPrefix(`/warden`)";
      service = "vaultwarden";
      middlewares = [ "vaultwarden-stripprefix" ];
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
