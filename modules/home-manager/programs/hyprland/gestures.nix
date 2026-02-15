{
  pkgs,
  lib,
  ...
}:
let
  scripts = import ./scripts.nix { inherit pkgs lib; };
  inherit (scripts) launcher;
in
{
  wayland.windowManager.hyprland.settings.gesture = [
    "3, left, dispatcher, layoutmsg, focus right"
    "3, right, dispatcher, layoutmsg, focus left"
    "3, vertical, workspace"
    "4, down, mod: ALT, close"
    # "3, up, exec,  ${launcher}"
  ];
}
