{
  pkgs,
  lib,
  settings,
  ...
}:
{
  imports = (
    map lib.custom.relativeToHomeModules [
      "shell/shell.nix"
    ]
  );

  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    openssl
    git
  ];
}
