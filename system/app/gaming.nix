{ pkgs, ... }:

{
  # OpenGL
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs = {
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
        # gamescopeSession = "gamescope";
        # gamescopeSession = "mangohud";}
      };
    };
    gamemode = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
    # steam
    gamemode
    mangohud
    lutris
  ];
}
