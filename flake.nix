{
  description = "andre-brandao NixOS configuration";

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      # nixos-hardware,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "nixos"; # hostname
        profile = "xps"; # select a host defined from hosts directory
        timezone = "America/Sao_Paulo"; # select timezone
        language = "en_US.UTF-8"; # select language
        locale = "pt_BR.UTF-8"; # select locale
        plymouthTheme = "lone"; # Check all themes on: https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/data/themes/adi1090x-plymouth-themes/shas.nix
      };

      # ----- USER SETTINGS ----- #
      userSettings = {
        username = "andre"; # username
        git-user = "andre-brandao";
        name = "Andre Brandao"; # name/identifier
        email = "82166576+andre-brandao@users.noreply.github.com";
        configDir = "/home/${userSettings.username}/dotfiles/nixos"; # absolute path of the local repo
        theme = "miramare"; # selcted theme from my themes directory (./themes/)
        wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/desk-env/ and ./system/desk-env/
        browser = "brave";
        term = "kitty"; # Default terminal command;
        shell = "zsh"; # Default shell;
        font = "JetBrains Mono"; # Selected font
        fontPkg = pkgs.jetbrains-mono; # Font package
        editor = "zed"; # Default editor;
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

      pkgs-unstable = import nixpkgs-unstable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
    in
    {
      formatter.${systemSettings.system} = pkgs.nixfmt-rfc-style;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        system = nixpkgs.lib.nixosSystem {
          modules = [ (./. + "/hosts" + ("/" + systemSettings.profile) + "/configuration.nix") ];
          specialArgs = {
            inherit inputs outputs;
            inherit systemSettings;
            inherit userSettings;
            inherit pkgs-unstable;
          };
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs; # Home-manager requires 'pkgs' instance
          modules = [ (./. + "/hosts" + ("/" + systemSettings.profile) + "/home.nix") ];
          extraSpecialArgs = {
            inherit inputs outputs;
            inherit systemSettings;
            inherit userSettings;
            inherit pkgs-unstable;
          };
        };
      };
    };

  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # HyperLand
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      # url = "github:hyprwm/Hyprland/v0.41.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    xremap-flake.url = "github:xremap/nix-flake"; # TODO: flake still not ready

    # Stylix
    stylix.url = "github:danth/stylix";

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";

    };
    zen-browser.url = "github:andre-brandao/zen-browser-flake";

  };
}
