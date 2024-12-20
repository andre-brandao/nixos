{ pkgs, ... }:
{
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    # Fonts
    # nerdfonts
    nerd-fonts.jetbrains-mono
    powerline
    font-awesome
  ];
}
