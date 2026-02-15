{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    powerline
    font-awesome
  ];
  environment.systemPackages = with pkgs; [
    material-symbols
    material-icons
  ];
}
