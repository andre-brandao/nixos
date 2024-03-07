{
  description = "andre@nixos XPS-13 config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # HyperLand
    hyprland.url = "github:hyprwm/Hyprland";

    # NIX formater
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    system = "x86_64-linux";
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.${system}.alejandra;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # TODO HOSTNAME HERE
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          ###SYSTEM CONFIGURATIONS
          ./nixos/configuration.nix
          ./nixos/sys-config/bootloader.nix
          ./nixos/sys-config/networking.nix
          ./nixos/sys-config/sound.nix
          ./nixos/sys-config/language.nix
          ./nixos/sys-config/fingerprint-scanner.nix
          ./nixos/sys-config/printer.nix
          ./nixos/sys-config/garbage-collection.nix

          ./nixos/sys-config/firewall.nix
          ./nixos/virtualization.nix

          ### USERS
          ./nixos/users.nix
          ### DESKTOP ENVIRONMENT ###
          ./nixos/desktop-managers/gnome.nix
          # ./nixos/desktop-managers/hyperland.nix

          ### PKGS
          ./nixos/packages.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # TODO user@hostname
      "andre@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
