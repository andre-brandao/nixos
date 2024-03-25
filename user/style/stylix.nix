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
    };
    fonts.sizes = {
      terminal = 18;
      applications = 12;
      popups = 12;
      desktop = 12;
    };
  };
  stylix.targets.alacritty.enable = false;
  programs.alacritty.settings = {
    colors = {
      # TODO revisit these color mappings
      # these are just the default provided from stylix
      # but declared directly due to alacritty v3.0 breakage
      primary.background = "#" + config.lib.stylix.colors.base00;
      primary.foreground = "#" + config.lib.stylix.colors.base07;
      cursor.text = "#" + config.lib.stylix.colors.base00;
      cursor.cursor = "#" + config.lib.stylix.colors.base07;
      normal.black = "#" + config.lib.stylix.colors.base00;
      normal.red = "#" + config.lib.stylix.colors.base08;
      normal.green = "#" + config.lib.stylix.colors.base0B;
      normal.yellow = "#" + config.lib.stylix.colors.base0A;
      normal.blue = "#" + config.lib.stylix.colors.base0D;
      normal.magenta = "#" + config.lib.stylix.colors.base0E;
      normal.cyan = "#" + config.lib.stylix.colors.base0B;
      normal.white = "#" + config.lib.stylix.colors.base05;
      bright.black = "#" + config.lib.stylix.colors.base03;
      bright.red = "#" + config.lib.stylix.colors.base09;
      bright.green = "#" + config.lib.stylix.colors.base01;
      bright.yellow = "#" + config.lib.stylix.colors.base02;
      bright.blue = "#" + config.lib.stylix.colors.base04;
      bright.magenta = "#" + config.lib.stylix.colors.base06;
      bright.cyan = "#" + config.lib.stylix.colors.base0F;
      bright.white = "#" + config.lib.stylix.colors.base07;
    };
    font.size = config.stylix.fonts.sizes.terminal;
  };

  home.packages = with pkgs; [ qt5ct pkgs.libsForQt5.breeze-qt5 ];
  home.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };
  programs.zsh.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };
  programs.bash.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };

  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze-dark";
  };
}
