# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  dconf,
  pkgs,
  ...
}: 

let
  inherit (builtins) readFile replaceStrings;
  inherit (lib) concatLines concatStringsSep genAttrs mapAttrsToList toShellVar;

  # palette = import ../resources/palette.nix { inherit lib; };

  # toAbbrs = kv: concatLines (mapAttrsToList (k: v: "abbr ${toShellVar k v}") kv);
in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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
    # GIT
    git = {
      enable = true;
      userName  = "andre-brandao";
      userEmail = "brandaoandre00@gmail.com";

      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };

      extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
     };

    };
     # shell

    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };
      
      # shellIntegration.enableFishIntegration = true;
      theme = "Catppuccin-Macchiato";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      # syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake ~/.dotfiles/minimal";
        home-update = "home-manager switch /home/andre/.dotfiles/minimal#andre@nixos";
      };
      history = {
        size = 1000000;
        path = "${config.xdg.dataHome}/zsh/history";
      };

      # zplug = {
      #   enable = true;
      #   plugins = [
      #     { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      #     { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      #   ];
      # };

      # oh-my-zsh = {
      #   enable = true;
      #   plugins = [ "git" "thefuck" ];
      #   theme = "robbyrussell";
      # };

      initExtraBeforeCompInit = with pkgs; ''
      # Powerlevel10k instant prompt
      if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Completions
      fpath+=(${zsh-completions}/src)
    '';

    initExtra = replaceStrings [
      "@zsh-abbr@"
      "@zsh-click@"
      "@zsh-powerlevel10k@"
      "@zsh-prezto-terminal@"
      "@zsh-syntax-highlighting@"
    ] (with pkgs; [
      "${zsh-abbr}/share/zsh/plugins/zsh-abbr/zsh-abbr.plugin.zsh"
      "${zsh-click}/share/zsh/plugins/click/click.plugin.zsh"
      "${zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
      "${zsh-prezto}/share/zsh-prezto/modules/terminal/init.zsh"
      "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    ]) (readFile ./init-extra.zsh);

    };
  };
  home.file.".p10k.zsh".source = ./p10k.zsh;
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
