{ inputs, config, pkgs, dconf, userSettings, ... }: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    # STYLES
    ../../user/style/stylix.nix # Styling and themes for my apps

    (./. + "../../../user/desk-env"
      + ("/" + userSettings.wm + "/" + userSettings.wm)
      + ".nix") # My window manager selected from flake


    # GAMES
    ../../user/app/gaming/gaming.nix



    ../../user/app/virtualization/virtualization.nix # My qemu + virt manager
    ../../user/app/git/git.nix # My git config
    # SHELL 
    ../../user/shell/shell.nix # My shell config
    ../../user/shell/cli-collection.nix # Useful CLI apps

    # PROGRAMMING LANGUAGES
    ../../user/lang/js.nix # My node.js config

    # EDITORS
    ../../user/app/editor/nvim # My nvim config
    ../../user/app/editor/helix # My emacs config
    ../../user/app/editor/vscode # My vscode config
  ];

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    spotify
    netflix
    # BROSWERS
    brave
    firefox

    minecraft

    # CODE
    # vscode

    # MESSAGING
    thunderbird
    discord

    # UTILS
    lf
    bitwarden
    # gimp
    inkscape
    vlc
    obs-studio

    # Core
    zsh
    alacritty
    # librewolf
    brave
    # qutebrowser
    # dmenu
    # rofi

    git
    # syncthing

    # Office
    libreoffice-fresh
    # mate.atril
    # xournalpp
    glib
    # newsflash
    gnome.nautilus
    gnome.gnome-calendar
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
    # kdenlive
    ffmpeg
    movit
    mediainfo
    libmediainfo
    mediainfo-gui
    # audio-recorder

    # Various dev packages
    # postman
    texinfo
    libffi
    zlib
    # nodePackages.ungit
  ];


  home.sessionVariables = {
    EDITOR = userSettings.editor;
    # SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };
}
