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
    # environment = {

    # };
    environmentFiles = [
      config.sops.templates."vaultwarden.env".path
    ];

  };

  # services.nginx.virtualHosts."vault.fable-company.ts.net" = {
  #   enableACME = true;
  #   forceSSL = true;
  #   locations."/" = {
  #     proxyPass = "http://127.0.0.1:${toString 8080}";
  #   };
  # };

}
