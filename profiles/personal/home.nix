{ inputs, config, pkgs, dconf, userSettings, ... }: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    inputs.stylix.homeManagerModules.stylix
    ../../user/style/stylix.nix # Styling and themes for my apps

    # (./. + "../../../user/desk-env"
    #   + ("/" + userSettings.wm + "/" + userSettings.wm)
    #   + ".nix") # My window manager selected from flake

    ../../user/app/gaming/gaming.nix

    ../../user/app/git/git.nix # My git config

    ../../user/shell/shell.nix # My shell config
    ../../user/shell/cli-collection.nix # Useful CLI apps

    ../../user/lang/js.nix # My node.js config

    # EDITORS
    ../../user/app/editor/nvim # My nvim config
    ../../user/app/editor/helix # My emacs config
  ];

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    spotify
    netflix
    # BROSWERS
    brave
    firefox

    # CODE
    vscode

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

    # GAMES
    minecraft

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
    # gnome.gnome-maps
    # openvpn
    # protonmail-bridge
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
    yt-dlp
    #freetube
    blender
    #blockbench-electron
    # cura
    obs-studio
    # kdenlive
    ffmpeg
    # (pkgs.writeScriptBin "kdenlive-accel" ''
    #   #!/bin/sh
    #   DRI_PRIME=0 kdenlive "$1"
    # '')
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
  
  # virt-manager + qemu config (virtual machines)
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    # SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };
}
