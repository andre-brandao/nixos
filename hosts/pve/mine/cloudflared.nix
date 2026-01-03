{ pkgs, config, ... }:
{
  sops.secrets."cloudflared-creds" = { };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "312c6307-1818-4409-ab7b-fb7e7b1d05e7" = {
        credentialsFile = "${config.sops.secrets.cloudflared-creds.path}";
        default = "http_status:404";
      };
    };
  };

}
