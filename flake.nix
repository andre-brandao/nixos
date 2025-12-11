{
  description = "deds flake";

  nixConfig = {
    extra-substituters = [
      # "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org/"
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      # "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      settings = import ./settings.nix;
      lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });

      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in
    {
      # formatter.${system} = pkgs.nixfmt-rfc-style;
      formatter = forEachSystem (pkgs: pkgs.nixfmt-rfc-style);
      # devShells.${system} = import ./shell.nix { inherit pkgs; };
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      overlays = import ./overlays { inherit inputs outputs; };

      nixosConfigurations = {
        xps = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/xps/configuration.nix
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            inherit settings;
            inherit inputs outputs lib;
          };
        };
        wsl = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/wsl/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            # inherit pkgs-unstable;
            inherit settings;
            inherit inputs outputs;
          };
        };
        iso = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/iso/configuration.nix
            # inputs.home-manager.nixosModules.home-manager
            # inputs.disko.nixosModules.disko
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

          ];
          specialArgs = {
            inherit settings;
            inherit inputs outputs;
          };
        };

        vault = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/pve-vault/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            { nixpkgs.hostPlatform = "x86_64-linux"; }
          ];
          specialArgs = {
            inherit settings;
            inherit inputs outputs;
          };
        };

      };
      packages."x86_64-linux" = {
        proxmox-lxc-template = inputs.nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          modules = [
            ./hosts/proxmox-lxc-template/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
          format = "proxmox-lxc";
          # optional arguments:
          # explicit nixpkgs and lib:
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          # lib = nixpkgs.legacyPackages.x86_64-linux.lib;
          # additional arguments to pass to modules:
          specialArgs = {
            # myExtraArg = "foobar";
            inherit settings;
            inherit inputs outputs;
          };

          # you can also define your own custom formats
          # customFormats = { "myFormat" = <myFormatModule>; ... };
          # format = "myFormat";
        };
      };
    };

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    #     nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colmena.url = "github:zhaofengli/colmena";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    color-schemes = {
      url = "github:andre-brandao/color-schemes";
      flake = false;
    };
    wallpapers = {
      url = "github:andre-brandao/wallpapers";
      flake = false;
    };
    stylix.url = "github:danth/stylix/release-25.11";
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    devenv.url = "github:cachix/devenv";
    dagger = {
      url = "github:dagger/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
}
