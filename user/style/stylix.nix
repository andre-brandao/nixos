{
  inputs,
  config,
  lib,
  pkgs,
  userSettings,
  stylixSettings,
  ...
}:
{
  imports = [
    # inputs.stylix.homeManagerModules.stylix
    ./gtk.nix
    ./qt.nix
  ];

  home.file.".currenttheme".text = userSettings.theme;
  # stylix.autoEnable = false;
  stylix = {
    # enable = true;
    # autoEnable = false;
    # polarity = stylixSettings.polarity;
    # image = stylixSettings.image;

    # # base16Scheme = ./. + themePath;
    # base16Scheme = stylixSettings.base16Scheme;

    # fonts = stylixSettings.fonts;

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
      #  neovim.enable = true;

      vscode.enable = true;
      mangohud.enable = true;
      vesktop.enable = true;

      spicetify.enable = false;
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

  # programs = {
  #   cava = {
  #     enable = true;
  #     settings = {
  #       color = {
  #         foreground = "'#${config.lib.stylix.colors.base0A}'";
  #         #background = base3;
  #         gradient = 1;
  #         gradient_color_1 = "'#${config.lib.stylix.colors.base0A}'";
  #         gradient_color_2 = "'#${config.lib.stylix.colors.base0B}'";
  #         gradient_color_3 = "'#${config.lib.stylix.colors.base0C}'";
  #         gradient_color_4 = "'#${config.lib.stylix.colors.base0D}'";
  #         gradient_color_5 = "'#${config.lib.stylix.colors.base0E}'";
  #       };
  #     };
  #   };
  # };
}
