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
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    # STYLES
    ../../user/style/stylix.nix # Styling and themes for my apps
    ../../user/style/gtk.nix # My gtk config

    ../../user/app/git/git.nix # My git config
    # SHELL
    ../../user/shell/shell.nix # My shell config
    # ../../user/shell/cli-collection.nix # Useful CLI apps

    # EDITORS
    #../../user/app/editor/helix # My emacs config
    #../../user/app/editor/vscode # My vscode config
  ];
  home.packages = with pkgs; [
    # spotify
    netflix
    # BROSWERS
    brave
    google-chrome
    # CODE
    # vscode
    # MESSAGING
    thunderbird
    discord
    # discord-screenaudio
    teams-for-linux

    # UTILS
    bitwarden
    # gimp
    vlc
    obs-studio

    # Core
    zsh
    alacritty

    git
    # Office
    libreoffice-fresh
    gnome.seahorse
    texliveSmall

    wine
    bottles
    # Media
    # gimp-with-plugins
    pinta
    # krita
    inkscape
    # musikcube
    vlc
    obs-studio
  ];

  home.stateVersion = "22.11"; # Please read the comment before changing.
}
