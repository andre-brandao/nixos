{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./extras/fonts.nix
  ];
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # services.xserver = {
  #   layout = "us";
  #   xkbVariant = "";
  # };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Enable automatic login for the user.
  # services.xserver.displayManager.auegin.user = "andre";

  # # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
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
  ];
}
