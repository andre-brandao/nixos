{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  hyprland-preview-share-picker = pkgs.callPackage ../pkgs/hyprland-preview-share-picker { };
  dev-scripts = pkgs.callPackage ../pkgs/dev-scripts { };
}
