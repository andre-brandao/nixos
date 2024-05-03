{ pkgs, ... }:

{
  # OpenGL
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  # programs.steam.enable = true;
  # programs.steam.gamescopeSession.enable = true;

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
    mangohud
    lutris
  ];
}
