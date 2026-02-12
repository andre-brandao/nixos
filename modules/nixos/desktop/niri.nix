{ pkgs, settings, ... }:
{
  imports = [
    ./extras/fonts.nix
    ./extras/others.nix
    ../services/ags.nix
  ];

  programs.niri.enable = true;

  # services.greetd =
  #   let
  #     tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  #     session = "niri";
  #   in

  #   {
  #     enable = true;
  #     settings = {
  #       initial_session = {
  #         command = "${session}";
  #         user = settings.username;
  #       };
  #       default_session = {
  #         command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
  #         user = "greeter";
  #       };
  #     };
  #   };
  environment = {
    systemPackages = with pkgs; [
      xwayland-satellite

      morewaita-icon-theme
      adwaita-icon-theme

      wl-clipboard
      wl-gammactl
      pavucontrol
      brightnessctl
      libnotify
      rofi

      nautilus
      alacritty
      # kdePackages.qtwayland
      # kdePackages.qtsvg
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      # WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
