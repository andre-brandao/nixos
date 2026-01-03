{
  pkgs,
  lib,
  # pkgs-unstable,
  # userSettings,
  settings,
  inputs,
  ...
}:
{

  imports = (
    map lib.custom.relativeToHomeModules [
      # STYLES
      "style.nix" # Styling and themes for my apps
      # DESKTOP
      "desktop/hyprland" # My window manager selected from flake
      # UTILS
      "rofi"
      "walker.nix"
      # user/app/walker.nix
      "lf"
      "spicetify.nix" # My spicetify coxnfig
      "git.nix" # My git config
      # user/app/nemo.nix
      "browser/zen.nix"
      # VIRTUALIZATION
      "qemu.nix" # My qemu + virt manager
      # user/app/virtualization/distrobox.nix # My distrobox config

      # TERMINAL
      # user/app/terminal/kitty.nix
      # user/app/terminal/alacritty.nix

      # SHELL
      "shell/shell.nix" # My shell config
      "shell/cli-collection.nix" # Useful CLI apps

      # EDITORS
      # user/app/editor/nvim # My nvim config
      "editor/helix" # My helix config
      # user/app/editor/vscode # My vscode config

      # ./bloat.home.nix
    ]
  );

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
    (with pkgs.unstable; [
      freerdp
      superfile
      ghostty
      zed-editor
      thunderbird # email client
      nemo
      jetbrains.idea
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
      # inputs.devenv.packages.${system}.default
      # inputs.dagger.packages.${system}.dagger
      # inputs.quickshell.packages.${system}.default
      # inputs.caelestia.packages.${system}.default
      devenv
      unstable.secretspec
      dagger

      # ---- OFFICE ---- #

      # libreoffice-fresh
      # ---- UTILS ---- #
      bitwarden-desktop # Password manager
      bitwarden-cli
      remmina
      vault
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
      (wineWowPackages.full.override {
        wineRelease = "staging";
        mingwSupport = true;
      })
      winetricks
    ]);

  home.sessionVariables =
    let
      editor = "zeditor";
      terminal = "ghostty";
    in
    {
      # BROWSER = userSettings.browser;
      TERM = terminal;
      EDITOR = editor;
      SPAWNEDITOR = (
        if (editor == "hx" || editor == "nvim") then "exec ${terminal} -e ${editor}" else editor
      );
    };

  home.stateVersion = "22.11"; # Please read the comment before changing.
}
