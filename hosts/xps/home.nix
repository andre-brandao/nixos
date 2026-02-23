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

      "programs/niri"

      "programs/qemu.nix"
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
  home.packages = with pkgs; [
    firefox-beta
    brave
    unstable.spotify
    unstable.discord
    teams-for-linux

    # ---- OFFICE ---- #
    # unstable.thunderbird # email client
    unstable.nemo
    unstable.superfile

    # libreoffice-fresh
    # ---- UTILS ---- #
    unstable.secretspec
    bitwarden-desktop # Password manager
    bitwarden-cli
    vault

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
    # blueman
    # kdenlive
    # ---- DEV UTILS ---- #
    unstable.ghostty
    unstable.zed-editor
    unstable.jetbrains.idea
    godot
    # icon-library
    # postman
    # (wineWowPackages.full.override {
    #   wineRelease = "staging";
    #   mingwSupport = true;
    # })
    # winetricks
    nixd
    devenv
    insomnia
    git
    zsh
    gum
    rclone
    # unstable.cachix
    unstable.obsidian

    unstable.freerdp
    remmina
  ];

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
