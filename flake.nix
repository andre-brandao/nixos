{
  description = "deds flake";

  nixConfig = {
    extra-substituters = [
      # "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org/"
      "https://devenv.cachix.org"
      "https://walker.cachix.org"
      "https://walker-git.cachix.org"
    ];
    extra-trusted-public-keys = [
      # "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
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
      formatter = forEachSystem (pkgs: pkgs.nixfmt-rfc-style);
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      overlays = import ./overlays { inherit inputs outputs; };

      nixosConfigurations = {
        xps = lib.nixosSystem {
          modules = [
            ./hosts/xps/configuration.nix
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-hardware.nixosModules.dell-xps-13-9300
          ];
          specialArgs = {
            inherit settings;
            inherit inputs outputs lib;
          };
        };
        wsl = lib.nixosSystem {
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
        # nix build .#nixosConfigurations.iso.config.system.build.isoImage
        iso = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
            ./hosts/iso/configuration.nix
            # { nixpkgs.hostPlatform = "x86_64-linux"; }
          ];
          specialArgs = {
            inherit settings;
            inherit inputs outputs;
          };
        };

        pve-vault = lib.nixosSystem {
          modules = [
            ./hosts/pve-vault/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.sops-nix.nixosModules.sops
            inputs.stylix.nixosModules.stylix
            inputs.disko.nixosModules.disko
            { nixpkgs.hostPlatform = "x86_64-linux"; }
          ];
          specialArgs = {
            inherit settings;
            inherit inputs outputs;
          };
        };
        pve-git = lib.nixosSystem {
          modules = [
            ./hosts/pve-git/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.sops-nix.nixosModules.sops
            inputs.stylix.nixosModules.stylix
            inputs.disko.nixosModules.disko
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
          format = "proxmox-lxc";
          modules = [
            ./hosts/pve-lxc-template/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            # myExtraArg = "foobar";
            inherit settings;
            inherit inputs outputs;
          };
        };
        proxmox-vma-template = inputs.nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "proxmox";
          modules = [
            ./hosts/pve-vma/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            # myExtraArg = "foobar";
            inherit settings;
            inherit inputs outputs;
          };
        };
      };
    };

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    systems.url = "github:nix-systems/default-linux";
    # The next two are for pinning to stable vs unstable regardless of what the above is set to
    # This is particularly useful when an upcoming stable release is in beta because you can effectively
    # keep 'nixpkgs-stable' set to stable for critical packages while setting 'nixpkgs' to the beta branch to
    # get a jump start on deprecation changes.
    # See also 'stable-packages' and 'unstable-packages' overlays at 'overlays/default.nix"
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ===== UTILS ======
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #     nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colmena.url = "github:zhaofengli/colmena";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
    dagger = {
      url = "github:dagger/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ====== STYLES ========
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
    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

  };
}
