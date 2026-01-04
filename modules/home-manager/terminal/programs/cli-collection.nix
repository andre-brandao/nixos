{ pkgs, ... }:
{
  # Collection of useful CLI apps
  home.packages = with pkgs; [

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
    fzf
    # pandoc
    pciutils
    ncdu
    tldr
    # expect
    dig
    jq

    tree
    # typer
    wev
  ];

}
