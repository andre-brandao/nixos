{ inputs, config, lib, pkgs, userSettings, ... }:
let
  themePath = "../../../themes"
    + ("/" + userSettings.theme + "/" + userSettings.theme) + ".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile
    (./. + "../../../themes" + ("/" + userSettings.theme) + "/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + "../../../themes"
    + ("/" + userSettings.theme) + "/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "../../../themes/"
    + ("/" + userSettings.theme) + "/backgroundsha256.txt");
in
{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  home.file.".currenttheme".text = userSettings.theme;

  # stylix.autoEnable = false;
  stylix = {
    polarity = themePolarity;
    image = pkgs.fetchurl {
      url = backgroundUrl;
      sha256 = backgroundSha256;
    };

    base16Scheme = ./. + themePath;

    fonts = {
      monospace = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      serif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      sansSerif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji-blob-bin;
      };
    };

    targets = {
      # lightdm.enable = true;
      gtk.enable = true;
      rofi.enable = true;
      vscode.enable = true;
      kitty.enable = true;
      alacritty.enable = true;
      tmux.enable = true;
    };
    fonts.sizes = {
      terminal = 18;
      applications = 12;
      popups = 12;
      desktop = 12;
    };
    opacity = {
      popups = 0.75;
      terminal = 0.75;
    };
  };

  # home.packages = with pkgs; [ qt5ct pkgs.libsForQt5.breeze-qt5 ];
  # home.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };
  # programs.zsh.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };
  # programs.bash.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };
  # qt = {
  #   enable = true;
  #   style.package = pkgs.libsForQt5.breeze-qt5;
  #   style.name = "breeze-dark";
  # };
}
