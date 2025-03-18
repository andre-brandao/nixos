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
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  programs.home-manager.enable = true;
  imports = [
    # STYLES
    # ../../user/style/stylix.nix # Styling and themes for my apps
    # ../../user/style/gtk.nix # My gtk config

    # DESKTOP
     ../../user/app/lf
     ../../user/app/git/git.nix
     ../../user/shell/shell.nix 
     ../../user/shell/cli-collection.nix

     ../../user/app/editor/helix
  ];
  # home.packages = with pkgs; [
  #   caligula
  # ];

  home.file."teste".text = "testando";
  home.stateVersion = "22.11"; # Please read the comment before changing.
}
