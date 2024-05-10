{
  inputs,
  config,
  pkgs,
  dconf,
  userSettings,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  programs.home-manager.enable = true;
  imports = [
    # STYLES
    ../../user/style/stylix.nix # Styling and themes for my apps
    ../../user/style/gtk.nix # My gtk config

    # DESKTOP
    ../../user/desk-env/${userSettings.wm} # My window manager selected from flakes
  ];
  programs.chromium = {
    enable = true;
    # package = pkgs.brave;
  };
  home.packages = with pkgs; [
    firefox
    git
    nvim
  ];
  home.stateVersion = "22.11"; # Please read the comment before changing.
}
