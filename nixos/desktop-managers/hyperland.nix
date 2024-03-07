{
  inputs,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system.
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "maya";
      autoNumlock = true;
    };
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Enable the X11 windowing system.
  # services.xserver = {
  #   enable = true;
  #   displayManager.gdm = {
  #     enable = true;
  #     wayland = true;
  #   };
  # };

  environment.systemPackages = with pkgs; [
    eww-wayland
    firefox-wayland

    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland

    rofi-wayland
    waybar
    wget
    wireplumber
    wl-color-picker
    wofi
    wlroots
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-utils
    xwayland
    ydotool
    zoxide
  ];

  # environment etc
  environment.etc = {
    "xdg/gtk-3.0" .source = ./gtk-3.0;
  };

  # Environment variables
  environment = {
    variables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_QPA_PLATFORM = "xcb obs";
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      });
    })
  ];
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
}
