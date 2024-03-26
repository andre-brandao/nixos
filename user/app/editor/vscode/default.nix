{ config, pkgs, inputs, ... }: {

  #programs.vscode = {
  # enable = true;
  #};
  home.packages = [ pkgs.vscode ];
}
