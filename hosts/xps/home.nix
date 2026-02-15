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
      "style.nix"
      "qemu.nix"

      "desktop/niri"

      "programs/browser/zen.nix"
      "programs/spicetify.nix"
      "programs/rofi"
      "programs/walker.nix"
      "programs/editors/helix"
      "programs/editors/helix/lsp.nix"

      "terminal/shell"
      "terminal/programs/lf"
      "terminal/programs/nix.nix"
      "terminal/programs/git.nix"
      "terminal/programs/zoxide.nix"
      "terminal/programs/cli-collection.nix"
    ]
  );

  programs = {
    chromium.enable = true;
    home-manager = {
      enable = true;
      # backupFileExtension = "backup";
    };
  };

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
      inputs.shell.packages.${system}.default
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
      godot
      gum
      rclone
      # (wineWowPackages.full.override {
      #   wineRelease = "staging";
      #   mingwSupport = true;
      # })
      # winetricks

      # (callPackage ../../pkgs/dev-scripts { })
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
