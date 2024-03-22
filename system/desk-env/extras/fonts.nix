{ pkgs, ... }: {
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    # Fonts
    nerdfonts
    powerline
    inconsolata
    inconsolata-nerdfont
    iosevka
    font-awesome
    ubuntu_font_family
    terminus_font
  ];
}
