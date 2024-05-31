{
  pkgs,
  inputs,
  userSettings,
  ...
}:
{
  imports = [ inputs.xremap-flake.homeManagerModules.default ];

  # home.packages = with pkgs; [ inputs.xremap-flake.packages.${system}.default ];

  services.xremap = {
    enable = true;
    # withHypr = true;
    withWlroots = true;

    config = {
      # Modmap for single key rebinds
      modmap = [
        {
          name = "Global";
          remap = {
            "CapsLock" = "Esc";
          }; # globally remap CapsLock to Esc
        }
      ];
      # Keymap for key combo rebinds
      keymap = [
        {
          name = "Firefox";
          remap = {
            "super-y" = "firefox";
          };
        }
      ];
    };
  };
}
