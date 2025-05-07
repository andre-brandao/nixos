{ inputs, pkgs, ... }:

rec {
  systemSettings = {
    system = "x86_64-linux"; # system arch
    hostname = "nixos"; # hostname
    profile = "xps"; # select a host defined from hosts directory
    timezone = "America/Sao_Paulo"; # select timezone
    language = "en_US.UTF-8"; # select language
    locale = "pt_BR.UTF-8"; # select locale
    plymouthTheme = "lone"; # Check all themes on: https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/data/themes/adi1090x-plymouth-themes/shas.nix
  };

  userSettings = {
    username = "andre"; # username
    git-user = "andre-brandao";
    name = "Andre Brandao"; # name/identifier
    email = "82166576+andre-brandao@users.noreply.github.com";
    configDir = "/home/${userSettings.username}/dotfiles/nixos"; # absolute path of the local repo
    theme = "miramare"; # selcted theme from my themes directory (./themes/)
    wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/desk-env/ and ./system/desk-env/
    browser = "zen";
    file-manager = "nemo";
    term = "ghostty"; # Default terminal command;
    shell = "zsh"; # Default shell;
    font = "JetBrains Mono"; # Selected font
    fontPkg = pkgs.jetbrains-mono; # Font package
    editor = "zeditor"; # Default editor;
  };

  stylixSettings = {
    polarity = "dark";
    image = "${inputs.wallpapers}/abstract102.png";
    base16Scheme = "${inputs.color-schemes}/base16/irblack.yaml";

    fonts = {
      sizes = {
        terminal = 18;
        applications = 12;
        popups = 12;
        desktop = 12;
      };
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
  };
}
