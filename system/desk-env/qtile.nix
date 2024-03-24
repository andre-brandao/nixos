{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./extras/fonts.nix
  ];

  services = {

    xserver = {
      enable = true;
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
      # Enable the GNOME Display Manager.
      displayManager.gdm.enable = true;
      # Enable the GNOME Desktop Environment.
      # desktopManager.gnome.enable = true;
      windowManager.qtile.enable = true;
      # xserver.libinput.naturalScrolling = true;
    };

  };
}
