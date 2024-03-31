{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./extras/fonts.nix
    ./extras/others.nix
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
      desktopManager.gnome = {
        enable = true;
        # excludePackages = with pkgs; [
        #   # gnome-text-editor
        #   gnome-console
        #   gnome-photos
        #   gnome-tour
        #   gnome-connections
        #   snapshot
        #   gedit
        #   gnome.cheese # webcam tool
        #   gnome.gnome-music
        #   gnome.epiphany # web browser
        #   gnome.geary # email reader
        #   gnome.evince # document viewer
        #   gnome.gnome-characters
        #   gnome.totem # video player
        #   gnome.tali # poker game
        #   gnome.iagno # go game
        #   gnome.hitori # sudoku game
        #   gnome.atomix # puzzle game
        #   gnome.yelp # Help view
        #   gnome.gnome-contacts
        #   gnome.gnome-initial-setup
        #   gnome.gnome-shell-extensions
        #   gnome.gnome-maps
        #   gnome.gnome-font-viewer
        # ];
      };
      # Enable automatic login for the user.
      # displayManager.auegin.user = "andre";
    };
  };
  # Enable the X11 windowing system.
  # # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
    gnome-extension-manager
    gnome3.gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.vitals
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gsconnect
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.toggle-alacritty
    gnomeExtensions.just-perfection
    gnomeExtensions.rounded-window-corners
  ];



}
