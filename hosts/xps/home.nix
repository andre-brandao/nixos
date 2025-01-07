{
  pkgs,
  pkgs-unstable,
  userSettings,
  inputs,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager = {
    enable = true;
    # backupFileExtension = "backup";
  };

  imports = [
    # STYLES
    ../../user/style/stylix.nix # Styling and themes for my apps
    ../../user/style/gtk.nix # My gtk config

    # DESKTOP
    # ../../overlays/hyprland-overlay.nix
    ../../user/desk-env/${userSettings.wm} # My window manager selected from flake

    ../../user/app/browser/${userSettings.browser}.nix # My browser config

    # UTILS
    ../../user/app/rofi
    ../../user/app/lf
    ../../user/app/spicetify.nix # My spicetify config
    ../../user/app/git/git.nix # My git config

    # VIRTUALIZATION
    ../../user/app/virtualization/qemu.nix # My qemu + virt manager
    ../../user/app/virtualization/distrobox.nix # My distrobox config

    # TERMINAL EMULATORS
    ../../user/app/terminal/kitty.nix
    ../../user/app/terminal/alacritty.nix

    # SHELL
    ../../user/shell/shell.nix # My shell config
    ../../user/shell/cli-collection.nix # Useful CLI apps

    # PROGRAMMING LANGUAGES
    ../../user/lang/js.nix # My node.js config
    ../../user/lang/go.nix # My go config
    ../../user/lang/godot.nix
    ../../user/lang/elixir.nix

    # EDITORS
    ../../user/app/editor/nvim # My nvim config
    ../../user/app/editor/helix # My helix config
    ../../user/app/editor/vscode # My vscode config

    # ./bloat.home.nix
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
    # spotify

    thunderbird # email client

    discord
    vesktop
    betterdiscordctl

    # protonmail-bridge-gui
    # protonmail-desktop
    protonmail-bridge
    # discord-screenaudio

    # ---- BROWSERS ---- #
    brave
    firefox
    inputs.zen-browser.packages."${system}".specific

    # ---- OFFICE ---- #
    # libreoffice-fresh
    obsidian
    # ---- UTILS ---- #
    bitwarden # Password manager
    # syncthing
    nautilus # File manager
    nemo
    dolphin

    # ---- WINDOWS ---- #
    wine
    # bottles

    # ---- 3D Modeling ---- #
    # blender

    # ---- MEDIA ---- #
    ffmpeg

    obs-studio
    vlc
    # kdenlive

    blueman
    mediawriter

    # ---- DEV UTILS ---- #
    icon-library
    postman
    libffi
    zlib
    glib

    inputs.ghostty.packages.x86_64-linux.default

    git

    zsh

    waveterm
    zed-editor

    supabase-cli
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
