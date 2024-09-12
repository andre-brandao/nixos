{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    bun
    dart-sass
    fd
    brightnessctl
    swww
    inputs.matugen.packages.${system}.default
    inputs.matcha.packages.${system}.default

    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
    libdbusmenu-gtk3
    gnome.gnome-bluetooth
  ];

  programs.ags = {
    enable = true;
    configDir = ./config;
    extraPackages = with pkgs; [ accountsservice ];
  };
}
