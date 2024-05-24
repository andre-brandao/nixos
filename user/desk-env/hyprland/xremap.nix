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
    withHypr = true;
    # withWlroots = true;

    # NOTE: since this sample configuration does not have any DE, xremap needs to be started manually by systemctl --user start xremap
    # serviceMode = "user";

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
