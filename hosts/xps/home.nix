{
  pkgs,
  pkgs-unstable,
  # userSettings,
  settings,
  inputs,
  ...
}:
{

  imports = [
    # STYLES
    ../../home-manager/style.nix # Styling and themes for my apps
    # DESKTOP
    ../../home-manager/desktop/hyprland # My window manager selected from flake
    # UTILS
    ../../home-manager/rofi
    # ../../user/app/walker.nix
    ../../home-manager/lf
    ../../home-manager/spicetify.nix # My spicetify coxnfig
    ../../home-manager/git.nix # My git config
    # ../../user/app/nemo.nix
    ../../home-manager/browser/zen.nix
    # VIRTUALIZATION
    ../../home-manager/qemu.nix # My qemu + virt manager
    # ../../user/app/virtualization/distrobox.nix # My distrobox config

    # TERMINAL
    # ../../user/app/terminal/kitty.nix
    # ../../user/app/terminal/alacritty.nix

    # SHELL
    ../../home-manager/shell/shell.nix # My shell config
    ../../home-manager/shell/cli-collection.nix # Useful CLI apps

    # EDITORS
    # ../../user/app/editor/nvim # My nvim config
    ../../home-manager/editor/helix # My helix config
    # ../../user/app/editor/vscode # My vscode config

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
  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;
  home.packages =
    (with pkgs-unstable; [
      freerdp
      superfile
      ghostty
      zed-editor
      thunderbird # email client
      nemo
      jetbrains.idea-community-bin
      # jetbrains.idea-ultimate
      cachix
      typescript-go
      discord
      obsidian
    ])
    ++ (with pkgs; [
      # ---- APPS ---- #
      # spotify
      # discord
      # vesktop
      # betterdiscordctl
      # ---- BROWSERS ---- #
      firefox-beta
      brave
      inputs.devenv.packages.${system}.default
      inputs.dagger.packages.${system}.dagger
      # inputs.quickshell.packages.${system}.default
      # inputs.caelestia.packages.${system}.default

      # ---- OFFICE ---- #

      # libreoffice-fresh
      # ---- UTILS ---- #
      bitwarden-desktop # Password manager
      bitwarden-cli
      remmina
      # syncthing
      # nautilus # File manager
      # dolphin
      protonmail-bridge
      teams-for-linux
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
      # postman
      insomnia
      # processing
      # libffi
      # zlib
      # glib
      # beekeeper-studio
      git
      zsh
      # protonmail-desktop
      # godot
      gum
      rclone
    ]);

  home.sessionVariables = {
    # BROWSER = userSettings.browser;
    # TERM = userSettings.term;
    EDITOR = settings.editor;
    SPAWNEDITOR = (
      if (settings.editor == "hx" || settings.editor == "nvim") then
        "exec ${settings.term} -e ${settings.editor}"
      else
        settings.editor
    );
  };

  home.stateVersion = "22.11"; # Please read the comment before changing.
}
