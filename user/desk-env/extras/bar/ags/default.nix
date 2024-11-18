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
    gnome-bluetooth
  ];

  programs.ags = {
    enable = true;
    package = inputs.ags.packages.${pkgs.system}.agsFull;
    # configDir = ./config;
    extraPackages =
      with pkgs;
      [
        accountsservice

        libgtop
        glib
        fzf
      ]
      ++ (with inputs.ags.packages.${pkgs.system}; [
        battery
        gnome-bluetooth
        hyprland
        notifd
        powerprofiles
        tray
        mpris
        network
        wireplumber
        apps
        io
        auth
        cava
        greet

      ]);
  };
}
