{
  lib,
  config,
  pkgs,
  inputs,
  userSettings,
  stylixSettings,
  ...
}:
{

  # imports = [ inputs.stylix.nixosModules.stylix ];

  # stylix.autoEnable = false;

  stylix = {
    enable = true;
    autoEnable = false;
    polarity = stylixSettings.polarity;
    image = stylixSettings.image;
    # pkgs.fetchurl {
    #   url = backgroundUrl;
    #   sha256 = backgroundSha256;
    # };

    # base16Scheme = ./. + themePath;
    base16Scheme = stylixSettings.base16Scheme;

    fonts = stylixSettings.fonts;

    targets = {
      lightdm.enable = true;
      console.enable = true;
      gtk.enable = true;
      gnome.enable = true;
      plymouth.enable = false;
      nixos-icons.enable = true;
      chromium.enable = true;
      grub.enable = true;
      grub.useImage = true;

    };
  };

  services.xserver.displayManager.lightdm = {
    greeters.slick.enable = true;
    greeters.slick.theme.name = lib.mkForce "Adwaita-dark";
  };
}

/*
  # REFERENCE
  https://stylix.danth.me/styling.html
  https://github.com/chriskempson/base16/blob/main/styling.md

  # GENERAL COLORS
  Default background: base00
  Alternate background: base01
  Selection background: base02
  Default text: base05
  Alternate text: base04
  Warning: base0A
  Urgent: base09
  Error: base08

  # WINDOW MANAGER

  Unfocused window border: base03
  Focused window border: base0D
  Unfocused window border in group: base03
  Focused window border in group: base0D
  Urgent window border: base08
  Window title text: base05

  # NOTIFICATION AND POPUPS

  Window border: base0D
  Low urgency background color: base06
  Low urgency text color: base0A
  High urgency background color: base0F
  High urgency text color: base08
  Incomplete part of progress bar: base01
  Complete part of progress bar: base02

  # DESKTOP HELPERS
  #
  Applications that fall under this group are applications that complement the window management facilities of whatever window manager the user is using. Examples of this include waybar and polybar, as well as the similar programs that are part of KDE and GNOME.
  Light text color widgets

  Refer to general colors above.
  Dark text color widgets

  These widgets use a different text color than usual to ensure it's still readable when the background is more vibrant.

  Default text color: base00
  Alternate text color: base01
  Item on background color: base0E
  Item off background color: base0D
  Alternate item on background color: base09
  Alternate item off background color: base02
  List unselected background: base0D
  List selected background: base03

  Note that the colors provided by the scheme won't necessarily match the names given below, although most handmade schemes do.

  Background color: base00
  Alternate background color: base01
  Main color: base05
  Alternate main color: base04
  Red: base08
  Orange: base09
  Yellow: base0A
  Green: base0B
  Cyan: base0C
  Blue: base0D
  Purple: base0E
  Brown: base0F
*/
