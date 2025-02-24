{
  lib,
  config,
  pkgs,
  inputs,
  userSettings,
  stylixSettings,
  ...
}:
{
  # imports = [ inputs.stylix.nixosModules.stylix ];

  # stylix.autoEnable = false;

  stylix = {
    enable = true;
    autoEnable = false;
    polarity = stylixSettings.polarity;
    image = stylixSettings.image;
    # pkgs.fetchurl {
    #   url = backgroundUrl;
    #   sha256 = backgroundSha256;
    # };

    # base16Scheme = ./. + themePath;
    base16Scheme = stylixSettings.base16Scheme;

    fonts = stylixSettings.fonts;

    targets = {
      lightdm.enable = true;
      console.enable = true;
      gtk.enable = true;
      gnome.enable = true;
      plymouth.enable = false;
      nixos-icons.enable = true;
      chromium.enable = true;
      grub.enable = true;
      grub.useImage = true;

      # #
      # hyprland.enable = false;
      # rofi.enable = true;
      # dunst.enable = true;

      # kitty.enable = true;
      # alacritty.enable = true;
      # tmux.enable = true;
      # bat.enable = true;
      # btop.enable = true;
      # fzf.enable = true;
      # lazygit.enable = true;

      # vim.enable = true;
      # #  neovim.enable = true;

      # vscode.enable = true;
      # mangohud.enable = true;
      # vesktop.enable = true;

      # spicetify.enable = false;
    };
  };

  services.xserver.displayManager.lightdm = {
    greeters.slick.enable = true;
    greeters.slick.theme.name = lib.mkForce "Adwaita-dark";
  };
}
