{ config, pkgs, inputs, ... }: {

  programs.vscode = {
    enable = true;
    # open source version of vscode
    package = pkgs.vscodium.fhs;
    userSettings = {
      "files.autoSave" = "off";
      "window.titleBarStyle" = "custom";
      "workbench.sideBar.location" = "right";
      "editor.renderWhitespace" = "boundary";
    };
  };
  home.packages = [
    #microsoft vscode
    pkgs.vscode
  ];
}
