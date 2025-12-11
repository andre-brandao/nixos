{ config, inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops.secrets."vaultwarden-domain" = { };
  sops.templates."vaultwarden.env".content = ''
    DOMAIN=${config.sops.placeholder."vaultwarden-domain"}
  '';
  virtualisation.oci-containers.containers."vaultwarden" = {
    image = "vaultwarden/server";
    autoStart = true;
    ports = [
      "8080:80/tcp"
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
}
