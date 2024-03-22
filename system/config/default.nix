{ config, pkgs, lib, ... }:
let
  nixos-conf-editor = import (pkgs.fetchFromGitHub {
    owner = "snowfallorg";
    repo = "nixos-conf-editor";
    rev = "0.1.2";
    sha256 = "sha256-/ktLbmF1pU3vFHeGooDYswJipNE2YINm0WpF9Wd1gw8=";
  }) { };
in {
  imports = [
    ./bootloader.nix
    ./firewall.nix
    ./networking.nix
    ./language.nix
    ./sound.nix
    ./printer.nix
    ./gc.nix
  ];

  environment.systemPackages = with pkgs;
    [
      nixos-conf-editor
      # rest of your packages
    ];
}
