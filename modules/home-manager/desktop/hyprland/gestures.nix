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
    "3, horizontal, workspace"
    "3, down, mod: ALT, close"
    # "3, up, exec,  ${launcher}"
  ];
}
