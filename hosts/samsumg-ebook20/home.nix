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

    # DESKTOP
    # (./. + "../../../user/desk-env" + ("/" + userSettings.wm)) 
    ../../user/desk-env/${userSettings.wm} # My window manager selected from flake

    # GAMES
    ../../user/app/gaming/gaming.nix

    ../../user/app/git/git.nix # My git config
    # SHELL 
    ../../user/shell/shell.nix # My shell config
    ../../user/shell/cli-collection.nix # Useful CLI apps

    # EDITORS
    ../../user/app/editor/helix # My emacs config
    ../../user/app/editor/vscode # My vscode config
  ];
  programs.chromium = {
    enable = true;
    # package = pkgs.brave;
  };
  home.packages = with pkgs; [
    spotify
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
    mpv

    blender
    obs-studio
  ];

  home.sessionVariables = {
    BROWSER = userSettings.browser;
    TERM = userSettings.term;
    EDITOR = userSettings.editor;
    SPAWNEDITOR = (
      if (userSettings.editor == "hx" || userSettings.editor == "nvim") then
        "exec ${userSettings.term} -e ${userSettings.editor}"
      else
        userSettings.editor
    );
  };

  home.stateVersion = "22.11"; # Please read the comment before changing.
}
