{
  description = "andre@nixos XPS-13 config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # HyperLand
    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };

    # Stylix

    stylix.url = "github:danth/stylix";

    # NIX formater
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      inherit (self) outputs;

      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "nixos"; # hostname
        profile =
          "personal"; # select a profile defined from my profiles directory
        timezone = "America/Sao_Paulo"; # select timezone
        language = "en_US.UTF-8"; # select language
        locale = "pt_BR.UTF-8"; # select locale
      };

      # ----- USER SETTINGS ----- #
      userSettings = rec {
        username = "andre"; # username
        name = "Andre Brandao"; # name/identifier
        email =
          "brandaoandre@gmail.com"; # email (used for certain configurations)
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        theme =
          "horizon-dark"; # selcted theme from my themes directory (./themes/)
        wm =
          "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
        # window manager type (hyprland or x11) translator
        wmType = if (wm == "hyprland") then "wayland" else "x11";
        browser =
          "brave"; # Default browser; must select one from ./user/app/browser/
        defaultRoamDir =
          "Personal.p"; # Default org roam directory relative to ~/Org
        term = "kitty"; # Default terminal command;
        font = "Intel One Mono"; # Selected font
        fontPkg = pkgs.intel-one-mono; # Font package
        editor = "code"; # Default editor;
      };

      # configure pkgs
      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        # overlays = [ rust-overlay.overlays.default ];
      };

    in {
      formatter.${systemSettings.system} =
        nixpkgs.legacyPackages.${systemSettings.system}.nixfmt;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # TODO HOSTNAME HERE
        system = nixpkgs.lib.nixosSystem {
          # > Our main nixos configuration file <
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile)
              + "/configuration.nix")
          ];
          specialArgs = {
            inherit inputs outputs;
            inherit (inputs) stylix;
            inherit (inputs) hyprland-plugins;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # TODO user@hostname
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs; # Home-manager requires 'pkgs' instance
          # > Our main home-manager configuration file <
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            inherit (inputs) stylix;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
    };
}
