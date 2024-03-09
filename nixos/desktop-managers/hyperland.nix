{
  inputs,
  config,
  lib,
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
    xwayland.enable = true;
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
    # firefox-wayland
    waybar
    dunst
    libnotify

    rofi-wayland
    swww
    # eww

    # qt5.qtwayland
    # qt6.qmake
    # qt6.qtwayland

    # rofi-wayland
    # waybar
    # wget
    # wireplumber
    # wl-color-picker
    # wofi
    # wlroots
    # xdg-desktop-portal-hyprland
    # xdg-desktop-portal-gtk
    # xdg-utils
    # xwayland
    # ydotool
    # zoxide
  ];

  # environment etc
  environment.etc = {
    "xdg/gtk-3.0" .source = ./hyperland_config/gtk-3.0;
  };

  # Environment variables
  environment = {
    variables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_QPA_PLATFORM = "xcb obs";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      });
    })
  ];

  # programs.waybar = {
  #   enable = true;
  #   systemd.enable = true;
  #   style = ''
  #     ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

  #     window#waybar {
  #       background: transparent;
  #       border-bottom: none;
  #     }

  #     * {
  #       ${
  #       if config.hostId == "nixos"
  #       then ''
  #         font-size: 18px;
  #       ''
  #       else ''

  #       ''
  #     }
  #     }
  #   '';
  #   settings = [
  #     {
  #       height = 30;
  #       layer = "top";
  #       position = "bottom";
  #       tray = {spacing = 10;};
  #       modules-center = ["sway/window"];
  #       modules-left = ["sway/workspaces" "sway/mode"];
  #       modules-right =
  #         [
  #           "pulseaudio"
  #           "network"
  #           "cpu"
  #           "memory"
  #           "temperature"
  #         ]
  #         ++ (
  #           if config.hostId == "yoga"
  #           then ["battery"]
  #           else []
  #         )
  #         ++ [
  #           "clock"
  #           "tray"
  #         ];
  #       battery = {
  #         format = "{capacity}% {icon}";
  #         format-alt = "{time} {icon}";
  #         format-charging = "{capacity}% ";
  #         format-icons = ["" "" "" "" ""];
  #         format-plugged = "{capacity}% ";
  #         states = {
  #           critical = 15;
  #           warning = 30;
  #         };
  #       };
  #       clock = {
  #         format-alt = "{:%Y-%m-%d}";
  #         tooltip-format = "{:%Y-%m-%d | %H:%M}";
  #       };
  #       cpu = {
  #         format = "{usage}% ";
  #         tooltip = false;
  #       };
  #       memory = {format = "{}% ";};
  #       network = {
  #         interval = 1;
  #         format-alt = "{ifname}: {ipaddr}/{cidr}";
  #         format-disconnected = "Disconnected ⚠";
  #         format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
  #         format-linked = "{ifname} (No IP) ";
  #         format-wifi = "{essid} ({signalStrength}%) ";
  #       };
  #       pulseaudio = {
  #         format = "{volume}% {icon} {format_source}";
  #         format-bluetooth = "{volume}% {icon} {format_source}";
  #         format-bluetooth-muted = " {icon} {format_source}";
  #         format-icons = {
  #           car = "";
  #           default = ["" "" ""];
  #           handsfree = "";
  #           headphones = "";
  #           headset = "";
  #           phone = "";
  #           portable = "";
  #         };
  #         format-muted = " {format_source}";
  #         format-source = "{volume}% ";
  #         format-source-muted = "";
  #         on-click = "pavucontrol";
  #       };
  #       "sway/mode" = {format = ''<span style="italic">{}</span>'';};
  #       temperature = {
  #         critical-threshold = 80;
  #         format = "{temperatureC}°C {icon}";
  #         format-icons = ["" "" ""];
  #       };
  #     }
  #   ];
  # };

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
}
