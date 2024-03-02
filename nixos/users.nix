{ pkgs ,inputs, ...}:

{
  users.defaultUserShell = pkgs.zsh;
  # USERS
  users.users = {
    andre = {
    isNormalUser = true;
    description = "Andre Brandao";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    
    packages = with pkgs; [
      inputs.home-manager.packages.${pkgs.system}.default
      firefox
      thunderbird
      lf
      bitwarden
      spotify
      # vscode
      brave
      discord
      gimp
      ];
    };
  };
}