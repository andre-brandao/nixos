{
  pkgs,
  pkgs-unstable,
  userSettings,
  inputs,
  ...
}:
{

  imports = [
    # STYLES
    ../../user/style/stylix.nix # Styling and themes for my apps
    ../../user/style/gtk.nix # My gtk config
    # DESKTOP
    ../../user/desktop/${userSettings.wm} # My window manager selected from flake
    # UTILS
    ../../user/app/rofi
    ../../user/app/lf
    ../../user/app/spicetify.nix # My spicetify coxnfig
    ../../user/app/git/git.nix # My git config
    ../../user/app/nemo.nix
    # VIRTUALIZATION
    ../../user/app/virtualization/qemu.nix # My qemu + virt manager
    # ../../user/app/virtualization/distrobox.nix # My distrobox config

    # TERMINAL
    ../../user/app/terminal/kitty.nix
    ../../user/app/terminal/alacritty.nix

    # SHELL
    ../../user/shell/shell.nix # My shell config
    ../../user/shell/cli-collection.nix # Useful CLI apps

    # EDITORS
    ../../user/app/editor/nvim # My nvim config
    ../../user/app/editor/helix # My helix config
    ../../user/app/editor/vscode # My vscode config

    # ./bloat.home.nix
  ];

  # services.blueman-applet.enable = true;

  programs.chromium = {
    enable = true;
    # package = pkgs.brave;
  };
  programs.home-manager = {
    enable = true;
    # backupFileExtension = "backup";
  };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  home.packages =
    (with pkgs-unstable; [
      freerdp
      superfile
      ghostty
      zed-editor
      discord
      thunderbird # email client
      obsidian
      nemo
      jetbrains.idea-community-bin
      cachix
    ])
    ++ (with pkgs; [
      # ---- APPS ---- #
      # spotify

      # discord
      # vesktop
      betterdiscordctl

      # ---- BROWSERS ---- #
      inputs.zen-browser.packages."${system}".twilight
      # ---- OFFICE ---- #
      # libreoffice-fresh
      # ---- UTILS ---- #
      # bitwarden # Password manager
      # syncthing
      # nautilus # File manager
      # dolphin
      protonmail-bridge
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
      # ---- DEV UTILS ---- #
      # icon-library
      postman
      libffi
      zlib
      glib
      git
      zsh
      protonmail-desktop
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
