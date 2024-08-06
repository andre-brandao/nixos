{ pkgs, lib, ... }:
{
# TODO fix kde overrides
  # qt = {
  #   enable = true;
  #   platformTheme = lib.mkForce "gnome";
  #   style.name = lib.mkForce "adwaita-dark";
  #   style.package = lib.mkForce pkgs.adwaita-qt;
  # };
}
