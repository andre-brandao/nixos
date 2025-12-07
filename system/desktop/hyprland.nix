{
  pkgs,
  pkgs-unstable,
  inputs,
  userSettings,
  ...
}:
{
  imports = [
    ./extras/fonts.nix
    ./extras/others.nix
    ./extras/ags.nix
  ];

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
        options = "grp:win_space_toggle";
      };
    };
    greetd =
      let
        tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
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
    pam.services.astal-auth = { };

    # pam.services.ags = { };
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        # pkgs.xdg-desktop-portal-hyprland
        # inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      ];
    };
  };

  programs = {
    kdeconnect.enable = true;
    hyprland = {
      enable = true;
      package = pkgs-unstable.hyprland;
      portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland = {
        enable = true;
      };
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
      gnome-calculator
      # gnome-clocks
      # gnome-software # for flatpak
      wl-clipboard
      wl-gammactl

      pavucontrol
      brightnessctl
      libnotify
      rofi
      # kitty # hyprland default terminal
      # kdePackages.qtwayland
      # kdePackages.qtsvg
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
