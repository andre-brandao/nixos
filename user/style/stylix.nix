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
    targets = {
      gtk.enable = true;
      gnome.enable = true;
      hyprland.enable = false;
      rofi.enable = true;
      dunst.enable = true;

      kitty.enable = true;
      alacritty.enable = true;
      ghostty.enable = true;
      tmux.enable = true;
      bat.enable = true;
      btop.enable = true;
      fzf.enable = true;
      lazygit.enable = true;

      vim.enable = true;
      #  neovim.enable = true;

      vscode.enable = true;
      mangohud.enable = true;
      # vesktop.enable = true;

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
}
