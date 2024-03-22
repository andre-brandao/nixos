{ pkgs, ... }: {
  # Import wayland config
  imports = [
    ./extras/wayland.nix
    # ./extras/pipewire.nix
    ./extras/dbus.nix
  ];

  # Security
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
    #    pam.services.gtklock = {};
    pam.services.login.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland = { enable = true; };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };
}
