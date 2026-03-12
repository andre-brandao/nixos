{
  pkgs,
  lib,
  settings,
  ...
}:
{
  imports = (
    map lib.custom.relativeToHomeModules [
      "terminal/shell"
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
