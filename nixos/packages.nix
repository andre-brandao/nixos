{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    #  home-manager  

    # NIX HELPERS
    alejandra

    # WEBDEV
    nodejs
    vscode

    # TERMINAL UTILS
    wezterm
    alacritty
    kitty
    kitty-themes
    ncdu
    htop
    thefuck
    duf
    fzf
  ];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
}