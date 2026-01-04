{ pkgs, ... }:
{

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.enableZshIntegration = true;

  home.packages = with pkgs; [
    # devbox
    nh
    direnv
    nix-direnv
    devenv
    # deadnix
    # nixfmt
    # statix
    nil
    nixd
    nix-tree
    # nix-init
    # statix
    nixfmt-rfc-style
    # nix-prefetch-git
    # nix-prefetch-github
    nix-output-monitor
  ];
}
