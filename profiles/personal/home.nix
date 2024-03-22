{ config, pkgs, dconf, stylix, userSettings, ... }: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    # stylix.homeManagerModules.stylix
    # ../../user/style/stylix.nix # Styling and themes for my apps

    # (./. + "../../../user/desk-env" + ("/" + userSettings.wm + "/" + userSettings.wm) + ".nix") # My window manager selected from flake
    ./waybar.nix
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
    dmenu
    rofi
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
    gnome.gnome-maps
    # openvpn
    # protonmail-bridge
    texliveSmall

    wine
    bottles
    # The following requires 64-bit FL Studio (FL64) to be installed to a bottle
    # With a bottle name of "FL Studio"
    # (pkgs.writeShellScriptBin "flstudio" ''
    #    #!/bin/sh
    #    if [ -z "$1" ]
    #      then
    #        bottles-cli run -b "FL Studio" -p FL64
    #        #flatpak run --command=bottles-cli com.usebottles.bottles run -b FL\ Studio -p FL64
    #      else
    #        filepath=$(winepath --windows "$1")
    #        echo \'"$filepath"\'
    #        bottles-cli run -b "FL Studio" -p "FL64" --args \'"$filepath"\'
    #        #flatpak run --command=bottles-cli com.usebottles.bottles run -b FL\ Studio -p FL64 -args "$filepath"
    #      fi
    # '')
    # (pkgs.makeDesktopItem {
    #   name = "flstudio";
    #   desktopName = "FL Studio 64";
    #   exec = "flstudio %U";
    #   terminal = false;
    #   type = "Application";
    #   mimeTypes = ["application/octet-stream"];
    # })

    # Media
    # gimp-with-plugins
    pinta
    krita
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
    audio-recorder

    # Various dev packages
    # postman
    texinfo
    libffi
    zlib
    # nodePackages.ungit
  ];

  # services.syncthing.enable = true;

  # xdg.enable = true;
  # xdg.userDirs = {
  #   enable = true;
  #   createDirectories = true;
  #   music = "${config.home.homeDirectory}/Media/Music";
  #   videos = "${config.home.homeDirectory}/Media/Videos";
  #   pictures = "${config.home.homeDirectory}/Media/Pictures";
  #   templates = "${config.home.homeDirectory}/Templates";
  #   download = "${config.home.homeDirectory}/Downloads";
  #   documents = "${config.home.homeDirectory}/Documents";
  #   desktop = null;
  #   publicShare = null;
  #   extraConfig = {
  #     XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
  #     XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
  #     XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
  #     XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
  #     XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
  #     XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
  #   };
  # };
  # xdg.mime.enable = true;
  # xdg.mimeApps.enable = true;

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
