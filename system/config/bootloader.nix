{ pkgs, systemSettings, ... }:
{
  # Bootloader.
  boot.loader.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.verbose = false;

  # # ----SYSTEMD----
  # boot.initrd.enable = true;
  # boot.initrd.systemd.enable = true;
  # boot.loader.systemd-boot.enable = true;
  # ---- end SYSTEMD ----

  # ----GRUB----
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

    };
  };
  # ---- end GRUB ----

  # ----PLYMOUTH----
  # check the link for the available themes
  # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/data/themes/adi1090x-plymouth-themes/shas.nix

  boot.plymouth =
    let
      theme = systemSettings.plymouthTheme;
    in
    {
      enable = true;
      inherit theme;
      themePackages = [ (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ theme ]; }) ];
    };

  # Make systemd and other related stuff shut up
  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    # Silences boot messages
    "quiet"
    # # Show a splash screen
    # "splash"

    "bgrt_disable"
    # Silences successfull systemd messages from the initrd
    "rd.systemd.show_status=false"
    # Silence systemd version number in initrd
    "rd.udev.log_level=3"
    # Silence systemd version number
    "udev.log_priority=3"
    # If booting fails drop us into a shell where we can investigate
    "boot.shell_on_fail"
  ];
}
