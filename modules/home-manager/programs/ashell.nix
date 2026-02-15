{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.ashell
    gawk
    nvd
  ];
}
/*
  cd ~/dotfiles/nixos && \
  nix flake update nixpkgs && \
  nix build .#nixosConfigurations.xps.config.system.build.toplevel --option max-jobs 2 && \
  nvd diff /run/current-system ./result | grep -e '\[U' | awk '{print $3, $4, "->", $5}'
*/
