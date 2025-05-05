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

    # ../../user/app/browser/${userSettings.browser}.nix # My browser config

    # UTILS
    ../../user/app/rofi
    ../../user/app/lf
    ../../user/app/spicetify.nix # My spicetify coxnfig
    ../../user/app/git/git.nix # My git config
    ../../user/app/nemo.nix

    # VIRTUALIZATION
    ../../user/app/virtualization/qemu.nix # My qemu + virt manager
    # ../../user/app/virtualization/distrobox.nix # My distrobox config

    # TERMINAL EMULATORS
    ../../user/app/terminal/kitty.nix
    ../../user/app/terminal/alacritty.nix

    # SHELL
    ../../user/shell/shell.nix # My shell config
    ../../user/shell/cli-collection.nix # Useful CLI apps

    # PROGRAMMING LANGUAGES
    # ../../user/lang/js.nix # My node.js config
    # ../../user/lang/go.nix # My go config
    # ../../user/lang/godot.nix
    # ../../user/lang/elixir.nix

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
  home.packages =
    with pkgs;
    [
      # ---- APPS ---- #
      # spotify

      # discord
      # vesktop
      betterdiscordctl

      # protonmail-bridge-gui
      # protonmail-desktop
      protonmail-bridge
      # discord-screenaudio

      # ---- BROWSERS ---- #
      # brave
      # firefox

      # (callPackage ../../packages/zen.nix { })
      inputs.zen-browser.packages."${system}".twilight
      # ---- OFFICE ---- #
      libreoffice-fresh

      # ---- UTILS ---- #
      # bitwarden # Password manager
      # syncthing
      # nautilus # File manager
      # dolphin

      # ---- WINDOWS ---- #
      # wine
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
      devbox
      devenv

      # icon-library
      postman
      libffi
      zlib
      glib
      rpi-imager

      git

      zsh

      # waveterm

      protonmail-desktop
    ]
    ++ (with pkgs-unstable; [
      freerdp
      superfile
      ghostty
      supabase-cli
      zed-editor
      discord
      thunderbird # email client
      obsidian
      # K8s
      claude-code
      railway
      lens
      kubernetes-helm
      kustomize
      nemo
      jetbrains.idea-community-bin
      vault
    ]);

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
