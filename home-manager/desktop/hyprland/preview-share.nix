{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.hyprland-preview-share-picker
  ];
  home.file = {
    "${config.xdg.configHome}/hypr/xdph.conf" = {
      text = ''
        screencopy {
          allow_token_by_default=false
          custom_picker_binary=${lib.getExe' pkgs.hyprland-preview-share-picker "hyprland-preview-share-picker"}
        }
      '';
    };
  };
}
