{
  description = "andre@nixos XPS-13 config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # HyperLand
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };

    # astal.url = "github:Aylur/astal";
    ags.url = "github:Aylur/ags"; # TODO:  (my config still in progress)

    xremap-flake.url = "github:xremap/nix-flake"; # TODO: flake still not ready

    # Stylix
    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      self,
      nixpkgs,
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
      };

      # ----- USER SETTINGS ----- #
      userSettings = {
        username = "andre"; # username
        git-user = "andre-brandao";
        name = "Andre Brandao"; # name/identifier
        email = "brandaoandre@gmail.com";
        configDir = "/home/${userSettings.username}/dotfiles/nixos"; # absolute path of the local repo
        theme = "gigavolt"; # selcted theme from my themes directory (./themes/)
        wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/desk-env/ and ./system/desk-env/
        browser = "brave";
        term = "alacritty"; # Default terminal command;
        font = "JetBrains Mono"; # Selected font
        fontPkg = pkgs.jetbrains-mono; # Font package
        editor = "codium"; # Default editor;
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
    in
    {
      formatter.${systemSettings.system} = pkgs.nixfmt-rfc-style;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        system = nixpkgs.lib.nixosSystem {
          modules = [
            (./. + "/hosts" + ("/" + systemSettings.profile) + "/configuration.nix")
            # nixos-hardware.nixosModules.dell-xps-13-9300
          ];
          specialArgs = {
            inherit inputs outputs;
            inherit systemSettings;
            inherit userSettings;
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
          };
        };
      };
    };
}
