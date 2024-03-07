# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  dconf,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./shell.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # HOME CONFIG
  home = {
    username = "andre";
    homeDirectory = "/home/andre";
    sessionVariables = {
      EDITOR = "vscode";
      BROWSER = "brave";
      TERMINAL = "wezterm";
    };

    packages = with pkgs; [
      # steam
      # firefox
      # thunderbird
      # lf
      # bitwarden
      # spotify
      # vscode
      # teams
      # discord
      neofetch
    ];
    # shell = pkgs.zsh;
  };

  # PROGRAMS
  programs = {
    home-manager = {
      enable = true;
    };

    # LF
    lf = {
      enable = true;

      commands = {
        dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
        editor-open = ''$$EDITOR $f'';
        mkdir = ''
          ''${{
            printf "Directory Name: "
            read DIR
            mkdir $DIR
          }}
        '';
      };

      keybindings = {
        "." = "set hidden!";
        "<enter>" = "open";

        do = "dragon-out";

        ee = "editor-open";

        V = ''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';
      };
    };

    # GIT
    git = {
      enable = true;
      userName = "andre-brandao";
      userEmail = "brandaoandre00@gmail.com";

      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };

      extraConfig = {
        credential.helper = "${
          pkgs.git.override {withLibsecret = true;}
        }/bin/git-credential-libsecret";
      };
    };
  };
  # virt-manager + qemu config (virtual machines)
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
