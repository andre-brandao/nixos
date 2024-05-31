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
    ../../user/desk-env/${userSettings.wm} # My window manager selected from flake

    # UTILS
    ../../user/app/rofi
    ../../user/app/lf

    # VIRTUALIZATION
    ../../user/app/virtualization/qemu.nix # My qemu + virt manager
    # ../../user/app/virtualization/distrobox.nix # My distrobox config

    ../../user/app/git/git.nix # My git config
    # SHELL 
    ../../user/shell/shell.nix # My shell config
    ../../user/shell/cli-collection.nix # Useful CLI apps

    # PROGRAMMING LANGUAGES
    ../../user/lang/js.nix # My node.js config
    ../../user/lang/go.nix # My go config
    ../../user/lang/godot.nix

    # EDITORS
    ../../user/app/editor/nvim # My nvim config
    ../../user/app/editor/helix # My emacs config
    ../../user/app/editor/vscode # My vscode config
  ];

  services = {
    blueman-applet.enable = true;
  };

  programs = {

    chromium = {
      enable = true;
      # package = pkgs.brave;
    };
  };
  home.packages = with pkgs; [
    # ---- APPS ---- #
    spotify
    netflix
    filezilla
    thunderbird # email client
    protonmail-bridge
    discord
    betterdiscordctl
    # discord-screenaudio
    teams-for-linux

    # ---- BROWSERS ---- #
    brave
    firefox

    # ---- OFFICE ---- #
    libreoffice-fresh
    # ---- UTILS ---- #
    bitwarden # Password manager
    # syncthing
    gnome.nautilus # File manager

    # ---- WINDOWS ---- #
    wine
    bottles

    # ---- 3D Modeling ---- #
    blender

    # ---- MEDIA ---- #
    ffmpeg
    movit
    mediainfo
    libmediainfo
    mediainfo-gui
    mpv
    obs-studio
    vlc
    # kdenlive
    gimp
    inkscape
    blueman

    # ---- DEV UTILS ---- #
    postman
    libffi
    zlib
    glib

    aircrack-ng
    netcat
    metasploit
    burpsuite

    git

    zsh
    alacritty

    rars
    zed-editor
    # jetbrains.pycharm-professional

    # ---- SERVICES ---- #
    supabase-cli
    turso-cli
    stripe-cli
    graphite-cli
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
