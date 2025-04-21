{
  description = "andre-brandao NixOS configuration";

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      # nixos-hardware,
      home-manager,
      stylix,
      ...
    }:
    let
      inherit (self) outputs;
      # configure pkgs
      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        overlays = [
          #  inputs.hyprpanel.overlay
          inputs.hyprland.overlays.default
          # inputs.hyprshell.overlays.default

          (final: prev: {
            #              pipewire = pkgs-unstable.pipewire;
            # mesa = pkgs-unstable.mesa;
            # gjs = pkgs-unstable.gjs;
            hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland; # .override {debug = true;};

          })
        ];
      };

      pkgs-unstable = import nixpkgs-unstable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };

      vars = import ./variables.nix { inherit inputs pkgs; };
      inherit (vars) systemSettings userSettings stylixSettings;
    in
    {
      formatter.${systemSettings.system} = pkgs.nixfmt-rfc-style;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        system = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/${systemSettings.profile}/configuration.nix
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit pkgs-unstable;

                inherit inputs outputs;

                inherit systemSettings;
                inherit userSettings;
                inherit stylixSettings;
              };
              home-manager.users.${userSettings.username} = import ./hosts/${systemSettings.profile}/home.nix;
            }
          ];
          specialArgs = {
            inherit pkgs-unstable;

            inherit inputs outputs;

            inherit systemSettings;
            inherit userSettings;
            inherit stylixSettings;
          };
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs; # Home-manager requires 'pkgs' instance
          modules = [
            # ./user/style/stylix.nix
            ./hosts/${systemSettings.profile}/home.nix

          ];
          extraSpecialArgs = {
            inherit pkgs-unstable;

            inherit inputs outputs;

            inherit systemSettings;
            inherit userSettings;
            inherit stylixSettings;
          };
        };
      };
    };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix.url = "github:danth/stylix/release-24.11";

    color-schemes = {
      url = "github:andre-brandao/color-schemes";
      flake = false;
    };

    wallpapers = {
      url = "github:andre-brandao/wallpapers";
      flake = false;
    };

    # HyperLand
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # url = "git+https://github.com/hyprwm/Hyprland?tag=v0.45.0?submodules=1";
      # url = "github:hyprwm/Hyprland/v0.45.2";
      # url = "github:hyprwm/Hyprland/v0.42.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprsysteminfo = {
      url = "github:hyprwm/hyprsysteminfo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    # Hyprland Bars
    hyprshell = {
      url = "github:andre-brandao/hyprshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    marble-shell = {
      url = "git+ssh://git@github.com/andre-brandao/marble?ref=dev";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };

  };
}
