{pkgs, ...}:{
    home.packages = with pkgs; [
      # hyprland packages
      hyprland-protocols
      # hypridle
      # hyprlock
      hyprpicker
      # hyprpaper
      pyprland
      cliphist

      swww

      hyprsysteminfo
      hyprsunset

      inputs.marble-shell.packages.${pkgs.system}.default
      inputs.marble-shell.packages.${pkgs.system}.astal

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
    ];
}
