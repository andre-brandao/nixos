{ pkgs, ... }:
{

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  # Enable fingerprint scanner
  # use fprint-enroll <username> to register a fingerprint
  services.fprintd = {
    enable = true;
    # package = pkgs.fprintd-tod;

    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
      # driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };
  # security.pam.services.login.fprintAuth = true;
  # security.pam.services.xscreensaver.fprintAuth = true;
}
