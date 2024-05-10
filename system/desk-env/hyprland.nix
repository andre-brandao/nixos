{ pkgs, inputs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./extras/fonts.nix
    ./extras/others.nix
    ./extras/ags.nix
    ../app/xremap.nix
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "grp:win_space_toggle";
    };
    # displayManager.gdm = {
    #   enable = true;
    #   wayland = true;
    #   # theme = "chili";
    # };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "chili";
      package = pkgs.sddm;
    };
  };

  security = {
    polkit.enable = true;
    # pam.services.ags = { };
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland = {
        enable = true;
      };
      # portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  environment = {
    systemPackages =
      with pkgs;
      with gnome;
      [
        gnome.adwaita-icon-theme
        loupe
        nautilus
        gnome-software # for flatpak
        wl-gammactl
        wl-clipboard
        # wayshot
        pavucontrol
        brightnessctl
        # swww
        libnotify
        rofi-wayland
        kitty # hyprland default terminal
      ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # hardware.opengl.enable = true;

  # services.dbus = {
  #   enable = true;
  #   packages = [ pkgs.dconf ];
  # };

  # programs.dconf = { enable = true; };
}
