{ config, ... }:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  sops.secrets."cloudflare_env" = { };

  services.tailscale.permitCertUid = "traefik";
  services.traefik = {
    enable = true;
    # environmentFiles = [
    #   config.sops.secrets."cloudflare_env".path
    # ];

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
        mc-java = {
          address = ":25566";
        };
        mc-bedrock = {
          address = ":19132/udp";

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
      certificatesResolvers = {
        cloudflare = {
          acme = {
            email = "eu+cloudflare@andrebrandao.dev";
            dnsChallenge = {
              provider = "cloudflare";
              # delayBeforeCheck = 0;
              resolvers = [
                "1.1.1.1:53"
                "1.0.0.1:53"
              ];
            };
          };
        };
        vpnresolver = {
          tailscale = { };
        };
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
            rule = "Host(`mine.fable-company.ts.net`) && PathPrefix(`/traefik`)";
            service = "api@internal";
            # middlewares = [ "auth" ];
            tls.certResolver = "vpnresolver";
          };
        };
      };

    };
  };

}
