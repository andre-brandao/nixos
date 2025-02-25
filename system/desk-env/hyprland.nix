{
  pkgs,
  inputs,
  userSettings,
  ...
}:
{
  imports = [
    ./extras/fonts.nix
    ./extras/others.nix
    ./extras/ags.nix
    # ../app/xremap.nix
  ];

  services = {
    xserver = {
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

    };
    greetd =
      let
        tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
        session = "Hyprland";
      in

      {
        enable = true;
        settings = {
          initial_session = {
            command = "${session}";
            user = userSettings.username;
          };
          default_session = {
            command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
            user = "greeter";
          };
        };
      };
  };

  security = {
    polkit.enable = true;
    # pam.services.ags = { };
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    };
  };

  programs = {
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland = {
        enable = true;
      };
      # portalPackage = pkgs.xdg-desktop-portal-hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      morewaita-icon-theme
      adwaita-icon-theme
      loupe
      # nautilus

      baobab
      gnome-text-editor
      gnome-calendar
      gnome-boxes
      gnome-system-monitor
      gnome-control-center
      gnome-weather
      gnome-calculator
      gnome-clocks
      gnome-software # for flatpak
      wl-clipboard
      wl-gammactl

      pavucontrol
      brightnessctl
      libnotify
      rofi-wayland
      # kitty # hyprland default terminal
      # kdePackages.qtwayland
      # kdePackages.qtsvg
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
