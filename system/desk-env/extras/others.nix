{ pkgs, inputs, ... }:
{

  services.gnome.gnome-keyring.enable = true;

  # hardware.graphics.enable = true;

  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  programs.dconf = {
    enable = true;
  };
}
