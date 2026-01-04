{ config, ... }:
{

  # sops.secrets = {
  #   "cf-dns-api-token" = {
  #     restartUnits = [ "traefik.service" ];
  #   };
  #   "cf-api-email" = {
  #     restartUnits = [ "traefik.service" ];
  #   };
  # };
  # sops.templates."traefik.env".content = ''
  #   CF_DNS_API_TOKEN=${config.sops.placeholder."cf-dns-api-token"}
  #   CF_API_EMAIL=${config.sops.placeholder."cf-api-email"}
  # '';
  # systemd.services.traefik.serviceConfig = {
  #   EnviromentFile = config.sops.secrets.my-password.path;
  # };
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  services.tailscale.permitCertUid = "traefik";
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
          asDefault = true;
          http.redirections.entrypoint = {
            to = "websecure";
            scheme = "https";
          };
        };

        websecure = {
          address = ":443";
          asDefault = true;
          http.tls.certResolver = "letsencrypt";
        };
      };

      log = {
        level = "INFO";
        filePath = "${config.services.traefik.dataDir}/traefik.log";
        format = "json";
      };

      # certificatesResolvers.letsencrypt.acme = {
      #   email = "postmaster@YOUR.DOMAIN";
      #   storage = "${config.services.traefik.dataDir}/acme.json";
      #   httpChallenge.entryPoint = "web";
      # };
      certificatesResolvers.vpnresolver = {
        tailscale = { };
      };

      api.dashboard = true;
      api.basepath = "/traefik";
      # Access the Traefik dashboard on <Traefik IP>:8080 of your server
      # api.insecure = true;
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          api = {
            rule = "Host(`vault.fable-company.ts.net`) && PathPrefix(`/traefik`)";
            service = "api@internal";
            # middlewares = [ "auth" ];
            tls.certResolver = "vpnresolver";
          };
        };
      };

    };
  };

}
