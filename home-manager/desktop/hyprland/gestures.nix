{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  scripts = import ./scripts.nix { inherit pkgs pkgs-unstable lib; };
  inherit (scripts) launcher;
in
{
  wayland.windowManager.hyprland.settings.gesture = [
    "3, horizontal, workspace"
    "3, down, mod: ALT, close"
    # "3, up, exec,  ${launcher}"
  ];
}
