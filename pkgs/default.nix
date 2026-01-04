{
  pkgs ? import <nixpkgs> { },
  ...
}:
rec {
  hyprland-preview-share-picker = pkgs.callPackage ../pkgs/hyprland-preview-share-picker { };

}
