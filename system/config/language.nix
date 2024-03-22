{ pkgs, systemSettings, ... }: {
  # Set your time zone.
  time.timeZone = systemSettings.timezone;
  # time sync
  services.timesyncd.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.language;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };
}
