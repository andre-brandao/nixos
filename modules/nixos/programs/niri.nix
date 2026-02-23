{ pkgs, settings, ... }:
{
  imports = [
    ../fonts.nix
    ./ags.nix
  ];

  programs.niri.enable = true;

  services.greetd =
    let
      tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
      session = "niri";
    in

    {
      enable = true;
      settings = {
        # initial_session = {
        #   command = "${session}";
        #   user = settings.username;
        # };
        default_session = {
          command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
          user = settings.username;
        };
      };
    };

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # Required for modern Intel GPUs (Xe iGPU and ARC)
      intel-media-driver # VA-API (iHD) userspace
      vpl-gpu-rt # oneVPL (QSV) runtime

      # Optional (compute / tooling):
      intel-compute-runtime # OpenCL (NEO) + Level Zero for Arc/Xe
      # NOTE: 'intel-ocl' also exists as a legacy package; not recommended for Arc/Xe.
      # libvdpau-va-gl       # Only if you must run VDPAU-only apps
    ];
  };

  # May help if FFmpeg/VAAPI/QSV init fails (esp. on Arc with i915):
  hardware.enableRedistributableFirmware = true;
  boot.kernelParams = [ "i915.enable_guc=3" ];

  # May help services that have trouble accessing /dev/dri (e.g., jellyfin/plex):
  # users.users.<service>.extraGroups = [ "video" "render" ];

  environment = {
    systemPackages = with pkgs; [
      xwayland-satellite

      morewaita-icon-theme
      adwaita-icon-theme

      wl-clipboard
      wl-gammactl
      pavucontrol
      playerctl
      brightnessctl
      libnotify

      swww
      nautilus
      # alacritty
      # kdePackages.qtwayland
      # kdePackages.qtsvg
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
      # VDPAU_DRIVER = "va_gl";      # Only if using libvdpau-va-gl

    };
  };
}
