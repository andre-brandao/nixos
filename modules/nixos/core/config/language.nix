{ pkgs, settings, ... }:
{
  # Set your time zone.
  time.timeZone = settings.timezone;
  # time sync
  services.timesyncd.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = settings.language;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = settings.locale;
    LC_IDENTIFICATION = settings.locale;
    LC_MEASUREMENT = settings.locale;
    LC_MONETARY = settings.locale;
    LC_NAME = settings.locale;
    LC_NUMERIC = settings.locale;
    LC_PAPER = settings.locale;
    LC_TELEPHONE = settings.locale;
    LC_TIME = settings.locale;
  };
}
