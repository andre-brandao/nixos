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
    enable = true;
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
      gnome.enable = true;
      hyprland.enable = false;
      rofi.enable = true;
      dunst.enable = true;

      kitty.enable = true;
      alacritty.enable = true;
      tmux.enable = true;
      bat.enable = true;
      btop.enable = true;
      fzf.enable = true;
      lazygit.enable = true;
      

      vim.enable = true;
      neovim.enable = true;

      vscode.enable = true;
      mangohud.enable = true;
      vesktop.enable = true;

      # spicetify.enable = true;
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
        color = {
          foreground = "'#${config.lib.stylix.colors.base0A}'";
          #background = base3;
          gradient = 1;
          gradient_color_1 = "'#${config.lib.stylix.colors.base0A}'";
          gradient_color_2 = "'#${config.lib.stylix.colors.base0B}'";
          gradient_color_3 = "'#${config.lib.stylix.colors.base0C}'";
          gradient_color_4 = "'#${config.lib.stylix.colors.base0D}'";
          gradient_color_5 = "'#${config.lib.stylix.colors.base0E}'";
        };
      };
    };
  };
}
