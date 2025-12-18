{
  pkgs,
  inputs,
  ...
}:
{

  services.gnome.gnome-keyring.enable = true;

  #   # hardware.graphics.enable = true;
  # hardware.graphics = {

  #     package = pkgs-unstable.mesa;

  #     # if you also want 32-bit support (e.g for Steam)
  #     driSupport32Bit = true;
  #     package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
  #   };

  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  programs.dconf = {
    enable = true;
  };
}
