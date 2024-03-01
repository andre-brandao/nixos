{ pkgs ,inputs, ...}:

{
  # USERS
  users.users = {
    andre = {
    isNormalUser = true;
    description = "Andre Brandao";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # firefox
      # thunderbird
      # lf
      # bitwarden
      # # spotify
      # vscode
      inputs.home-manager.packages.${pkgs.system}.default
      brave

      ];
    };
  };
}