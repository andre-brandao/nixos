{
  description = "andre@nixos XPS-13 config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-unstalble.url = "github:nixos/nixpkgs/nixos-unstalble";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # HyperLand
    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };

    # Stylix

    stylix.url = "github:danth/stylix";

    # NixVim
    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    stylix,
    hyprland-plugins,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # ---- SYSTEM SETTINGS ---- #
    systemSettings = {
      system = "x86_64-linux"; # system arch
      hostname = "nixos"; # hostname
      profile = "personal"; # select a profile defined from my profiles directory
      timezone = "America/Sao_Paulo"; # select timezone
      language = "en_US.UTF-8"; # select language
      locale = "pt_BR.UTF-8"; # select locale
      # bootMode = "uefi"; # uefi or bios
      # bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
      # grubDevice = ""; # device identifier for grub; only used for legacy (bios) boot mode
    };

    # ----- USER SETTINGS ----- #
    userSettings = rec {
      username = "andre"; # username
      name = "Andre Brandao"; # name/identifier
      email = "brandaoandre@gmail.com"; # email (used for certain configurations)
      dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
      theme = "horizon-dark"; # selcted theme from my themes directory (./themes/)
      wm = "gnome"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
      # window manager type (hyprland or x11) translator
      wmType =
        if (wm == "hyprland")
        then "wayland"
        else "x11";
      browser = "brave"; # Default browser; must select one from ./user/app/browser/
      defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
      term = "alacritty"; # Default terminal command;
      font = "Intel One Mono"; # Selected font
      fontPkg = pkgs.intel-one-mono; # Font package
      editor = "code"; # Default editor;
      # editor spawning translator
      # generates a command that can be used to spawn editor inside a gui
      # EDITOR and TERM session variables must be set in home.nix or other module
      # I set the session variable SPAWNEDITOR to this in my home.nix for convenience
      spawnEditor =
        if (editor == "emacsclient")
        then "emacsclient -c -a 'emacs'"
        else
          (
            if ((editor == "vim") || (editor == "nvim") || (editor == "nano"))
            then "exec " + term + " -e " + editor
            else editor
          );
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

    lib = nixpkgs.lib;

    supportedSystems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ];

    # Function to generate a set based on supported systems:
    forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

    # Attribute set of nixpkgs for each system:
    nixpkgsFor =
      forAllSystems (system:
        import inputs.nixpkgs {inherit system;});
  in {
    formatter.${systemSettings.system} = nixpkgs.legacyPackages.${systemSettings.system}.alejandra;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # TODO HOSTNAME HERE
      system = nixpkgs.lib.nixosSystem {
        # > Our main nixos configuration file <
        modules = [
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
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
