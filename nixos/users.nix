{ pkgs ,inputs, ...}:

{
  users.defaultUserShell = pkgs.zsh;
  # USERS
  users.users = {
    andre = {
    isNormalUser = true;
    description = "Andre Brandao";
    extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    shell = pkgs.zsh;
    
    packages = with pkgs; [
      inputs.home-manager.packages.${pkgs.system}.default

      spotify
      
      # BROSWERS
      brave
      firefox

      # CODE
      vscode
      
      # MESSAGING
      thunderbird
      discord

      # UTILS
      lf
      bitwarden
      gimp
      inkscape
      vlc
      obs-studio

      # GAMES
      minecraft
      ];
    };
  };
}
