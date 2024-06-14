{ pkgs, ... }:
{
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # ---- NIX UTILS ---- #
    nil
    nixd
    nix-tree
    nix-init
    statix
    nixfmt-rfc-style

    nix-prefetch-git
    nix-prefetch-github
    # ---- OTHER CLI ---- #
    gnugrep
    gnused
    killall
    libnotify
    timer
    bat
    eza
    fd
    bottom
    ripgrep
    rsync
    # tmux
    htop
    btop
    hwinfo
    unzip
    w3m
    fzf
    pandoc
    pciutils
    ncdu
    tldr
    expect
    dig
    jq

    # ---- FETCHERS ---- #
    disfetch
    neofetch
    onefetch
    starfetch
    cava
  ];

  programs = {
    # BETTER CD
    zoxide.enable = true;

    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
