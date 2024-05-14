{
  inputs,
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:
let
  themePath = "../../../themes" + ("/" + userSettings.theme + "/" + userSettings.theme) + ".yaml";
  themePolarity = lib.removeSuffix "\n" (
    builtins.readFile (./. + "../../../themes" + ("/" + userSettings.theme) + "/polarity.txt")
  );
  backgroundUrl = builtins.readFile (
    ./. + "../../../themes" + ("/" + userSettings.theme) + "/backgroundurl.txt"
  );
  backgroundSha256 = builtins.readFile (
    ./. + "../../../themes/" + ("/" + userSettings.theme) + "/backgroundsha256.txt"
  );
in
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
    ./gtk.nix
    ./qt.nix
  ];

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
      gtk.enable = true;
      hyprland.enable = false;
      rofi.enable = true;
      vscode.enable = true;
      kitty.enable = true;
      alacritty.enable = true;
      tmux.enable = true;
      dunst.enable = true;
      bat.enable = true;
      btop.enable = true;
      fzf.enable = true;
      gnome.enable = true;
      lazygit.enable = true;
      mangohud.enable = true;
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
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 22;
    };
  };

  programs = {
        cava = {
      enable = true;
      settings = {
        color =
          let
            baseA = "'#${config.lib.stylix.colors.base0A}'";
            baseB = "'#${config.lib.stylix.colors.base0B}'";
            baseC = "'#${config.lib.stylix.colors.base0C}'";
            baseD = "'#${config.lib.stylix.colors.base0D}'";
            baseE = "'#${config.lib.stylix.colors.base0E}'";
          in
          {
            foreground = baseA;
            #background = base3;
            gradient = 1;
            gradient_color_1 = baseA;
            gradient_color_2 = baseB;
            gradient_color_3 = baseC;
            gradient_color_4 = baseD;
            gradient_color_5 = baseE;
          };
      };
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
