{
  description = "deds flake ";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;

      system = "x86_64-linux";
      pkgsConfig = {
        allowUnfree = false;
        allowUnfreePredicate =
          pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "spotify"
            "steam-unwrapped"
            "steam"
            "discord"
            "obsidian"
          ];
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            devenv = inputs.devenv.packages.${system}.devenv;
          })
        ];
        config = pkgsConfig;
      };
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config = pkgsConfig;
      };

      settings = {
        username = "andre";
        editor = "zeditor";
        terminal = "ghostty";
        timezone = "America/Sao_Paulo";
        language = "en_US.UTF-8";
        locale = "pt_BR.UTF-8";
        hostname = "nixos";
        git = {
          user = "andre-brandao";
          email = "82166576+andre-brandao@users.noreply.github.com";
        };
        configDir = "/home/andre/dotfiles/nixos/v2";
      };
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;

      nixosConfigurations = {
        xps = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/xps/configuration.nix
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            inherit pkgs-unstable;
            inherit settings;
            inherit inputs outputs;
          };
        };
      };
    };
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
}
