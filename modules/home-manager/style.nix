{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  # imports = [
  #   # inputs.stylix.homeManagerModules.stylix
  #   ./gtk.nix
  #   ./qt.nix
  # ];

  # home.file.".currenttheme".text = userSettings.theme;
  # stylix.autoEnable = false;
  stylix = {
    targets = {
      gtk.enable = true;
      gnome.enable = true;
      hyprland.enable = false;
      rofi.enable = true;
      dunst.enable = true;

      kitty.enable = true;
      alacritty.enable = false;
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
      swaync.enable = false;
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

  # GTK
  # TODO: fix this
  # gtk = {
  #   enable = true;
  #   theme = lib.mkDefault {
  #     package = pkgs.flat-remix-gtk;
  #     name = "Flat-Remix-GTK-Grey-Darkest";
  #   };

  #   iconTheme = {
  #     package = pkgs.gnome.adwaita-icon-theme;
  #     name = "Adwaita";
  #   };
  # };

  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "adwaita";
    style.name = lib.mkForce "adwaita-dark";
    style.package = lib.mkForce pkgs.adwaita-qt;
  };
}
