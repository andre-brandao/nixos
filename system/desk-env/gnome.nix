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
      desktopManager.gnome.enable = true;
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

  gnome.excludePackages = (with pkgs; [
    # gnome-text-editor
    gnome-console
    gnome-photos
    gnome-tour
    gnome-connections
    snapshot
    gedit
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-contacts
    gnome-initial-setup
    gnome-shell-extensions
    gnome-maps
    gnome-font-viewer
  ]);



}
