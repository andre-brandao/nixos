{ pkgs, ... }: {
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # ---- NIX UTILS ---- #
    nil
    nixd
    nixpkgs-fmt
    nix-tree
    nix-init
    statix



    # ---- SERVICES ---- #
    supabase-cli
    turso-cli
    stripe-cli
    graphite-cli




    # ---- OTHER CLI ---- #
    disfetch
    neofetch
    onefetch
    starfetch
    cava
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
    brightnessctl # control laptop screen
    w3m
    fzf
    pandoc
    pciutils
    ncdu
    expect

    # ntfy
  ];
}
