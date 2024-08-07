{
  lib,
  config,
  pkgs,
  inputs,
  userSettings,
  ...
}:
let
  themePath = "../../../themes/" + userSettings.theme + "/" + userSettings.theme + ".yaml";
  themePolarity = lib.removeSuffix "\n" (
    builtins.readFile (./. + "../../../themes" + ("/" + userSettings.theme) + "/polarity.txt")
  );
  backgroundUrl = builtins.readFile (
    ./. + "../../../themes" + ("/" + userSettings.theme) + "/backgroundurl.txt"
  );
  backgroundSha256 = builtins.readFile (
    ./. + "../../../themes/" + ("/" + userSettings.theme) + "/backgroundsha256.txt"
  );
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  # stylix.autoEnable = false;

  stylix = {
    enable = true;
    polarity = themePolarity;
    image = pkgs.fetchurl {
      url = backgroundUrl;
      sha256 = backgroundSha256;
    };

    base16Scheme = ./. + themePath;

    fonts = {
      monospace = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      serif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      sansSerif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji-blob-bin;
      };
    };

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
