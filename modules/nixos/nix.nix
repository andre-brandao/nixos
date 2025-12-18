{
  lib,
  inputs,
  outputs,
  config,
  settings,
  ...
}:
{
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
      (lib.filterAttrs (_: lib.isType "flake")) inputs
    );
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    extraOptions = ''
      trusted-users = root ${settings.username}
    '';
  };

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  nixpkgs = {
    # You can add overlays here
    overlays = builtins.attrValues outputs.overlays;
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = false;
      # Enable unfree packages you want to use
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) settings.allowUnfree;

      # permittedInsecurePackages = [
      #   "beekeeper-studio-5.1.5"
      # ];
    };
  };

}
