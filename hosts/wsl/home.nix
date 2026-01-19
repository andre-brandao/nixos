{
  inputs,
  config,
  pkgs,
  lib,
  dconf,
  settings,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;
  programs.home-manager.enable = true;
  # imports = [
  #   # STYLES
  #   # ../../user/style/stylix.nix # Styling and themes for my apps
  #   # ../../user/style/gtk.nix # My gtk config

  #   # DESKTOP
  #   # ../../user/app/lf
  #   ../../user/app/git/git.nix
  #   ../../user/shell/shell.nix
  #   # ../../user/shell/cli-collection.nix

  #   # ../../user/app/editor/helix
  # ];

  imports = (
    map lib.custom.relativeToHomeModules [
      "style.nix"
      "terminal/shell"
      "terminal/programs/lf"
      "terminal/programs/nix.nix"
      "terminal/programs/git.nix"
      "terminal/programs/zoxide.nix"
      "programs/editors/helix"
    ]
  );
  home.packages = with pkgs; [
    devenv
  ];

  # home.file."teste".text = "testando";
  home.stateVersion = "22.11"; # Please read the comment before changing.
}
