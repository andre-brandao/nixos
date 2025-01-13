{
  description = "andre-brandao NixOS configuration";

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      # nixos-hardware,
      home-manager,
      stylix,
      ...
    }@inputs:
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
        ];
      };

      pkgs-unstable = import nixpkgs-unstable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };

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
        browser = "zen";
        term = "ghostty"; # Default terminal command;
        shell = "zsh"; # Default shell;
        font = "JetBrains Mono"; # Selected font
        fontPkg = pkgs.jetbrains-mono; # Font package
        editor = "zed"; # Default editor;
      };

      stylixSettings = {
        polarity = "dark";
        image = "${inputs.wallpapers}/red-sunset.png";
        base16Scheme = "${inputs.color-schemes}/base16/irblack.yaml";

        fonts = {
          sizes = {
            terminal = 18;
            applications = 12;
            popups = 12;
            desktop = 12;
          };
          monospace = {
            name = userSettings.font;
            package = userSettings.fontPkg;
          };
          serif = {
            name = userSettings.font;
            package = userSettings.fontPkg;
          };
          sansSerif = {
            name = userSettings.font;
            package = userSettings.fontPkg;
          };
          emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-emoji-blob-bin;
          };
        };
      };
    in
    {
      formatter.${systemSettings.system} = pkgs.nixfmt-rfc-style;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        system = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/${systemSettings.profile}/configuration.nix
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username} = import ./hosts/${systemSettings.profile}/home.nix;
              home-manager.extraSpecialArgs = {
                inherit pkgs-unstable;

                inherit inputs outputs;

                inherit systemSettings;
                inherit userSettings;
                inherit stylixSettings;
              };
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # HyperLand
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # url = "git+https://github.com/hyprwm/Hyprland?tag=v0.45.0?submodules=1";
      # url = "github:hyprwm/Hyprland/v0.45.2";

      # url = "github:hyprwm/Hyprland/v0.42.0";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprshell = {
      # url = "github:andre-brandao/hyprshell";
      url = "git+ssh://git@github.com/andre-brandao/marble?ref=dev";
      inputs.nixpkgs.follows = "nixpkgs";
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

    # Stylix
    stylix.url = "github:danth/stylix";

    color-schemes = {
      url = "github:andre-brandao/color-schemes";
      flake = false;
    };

    wallpapers = {
      url = "github:andre-brandao/wallpapers";
      flake = false;
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";

    };

    zen-browser.url = "github:MarceColl/zen-browser-flake";

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

  };
}
