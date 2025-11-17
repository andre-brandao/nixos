{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # hyprland packages
    hyprland-protocols
    # hypridle
    # hyprlock
    hyprpicker
    # hyprpaper
    pyprland
    cliphist
    syshud
    swww

    blueberry
    hyprsysteminfo
    hyprsunset

    # (inputs.caelestia-shell.packages.${pkgs.system}.default.override { withCli = true; })
    # inputs.marble-shell.packages.${pkgs.system}.default
    # inputs.marble-shell.packages.${pkgs.system}.astal
    # inputs.shell.packages.${pkgs.system}.default
    networkmanagerapplet # network manager
    pavucontrol # volume control
    pamixer # volume control

    wl-clipboard # clipboard manager

    grim # screenshot
    swappy
    slurp

    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    kdePackages.qtsvg
    xdg-utils # for opening files with default applications

    # xwaylandvideobridge # screen sharing
    # vesktop # discord client

    # waybar
    # dunst
    # nwg-dock-hyprland
    # nwg-drawer
    # nwg-launchers
    #
    gromit-mpx
    (writeShellScriptBin "walpaper-picker" ''
      ${waypaper}/bin/waypaper --backend swww --folder ~/Pictures/Wallpapers
    '')
  ];
}
