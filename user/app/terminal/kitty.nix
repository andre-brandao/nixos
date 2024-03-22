{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ kitty ];
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };

    # shellIntegration.enableFishIntegration = true;
    theme = "Catppuccin-Macchiato";
    settings = {
      background_opacity = lib.mkForce "0.55";
      background_opacity_when_focused = lib.mkForce "0.75";
    };
  };
}
