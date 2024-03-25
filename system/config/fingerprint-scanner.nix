{ pkgs, ... }: {
  # Enable fingerprint scanner
  services.fprintd = {
    enable = true;
    tod.enable = true;
  };
}
