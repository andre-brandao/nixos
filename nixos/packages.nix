{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    #  home-manager  

    # WEBDEV
    nodejs
    vscode

    # TERMINAL UTILS
    alacritty
    kitty
    kitty-themes
    ncdu

    # VIRTUAL MACHINES
    virt-manager
    qemu
  ];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
}