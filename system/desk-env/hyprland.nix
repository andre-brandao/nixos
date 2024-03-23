{ pkgs, inputs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./extras/fonts.nix
    ./extras/others.nix
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      # theme = "chili";
    };
  };

  # Security
  # security = {
  #   pam.services.swaylock = {
  #     text = ''
  #       auth include login
  #     '';
  #   };
  #   #    pam.services.gtklock = {};
  #   pam.services.login.enableGnomeKeyring = true;
  # };

  # services.gnome.gnome-keyring.enable = true;

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;

      xwayland = { enable = true; };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      wireplumber

      # (waybar.overrideAttrs (oldAttrs: {
      #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      # })
      # )

      hyprpaper

      swww
      dunst
      libnotify
      rofi-wayland
      # hyperland default
      kitty
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # hardware.opengl.enable = true;

  # services.dbus = {
  #   enable = true;
  #   packages = [ pkgs.dconf ];
  # };

  # programs.dconf = { enable = true; };
}
