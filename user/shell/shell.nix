{
  inputs,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:
let
  aliases = {
    # -- REBUILD SYSTEM
    # sys-update = "sudo nixos-rebuild switch --flake ${userSettings.configDir}/nixos#system ";
    sys-update = "nh os switch ${userSettings.configDir}  -H system";
    # -- REBUILD USER
    # user-update = "home-manager switch --flake ${userSettings.configDir}/nixos#user";
    user-update = "nh home switch ${userSettings.configDir} -c user";

    ls = "eza --icons -l -T -L=1";
    cat = "bat";
    htop = "btop";
    fd = "fd -Lu";
    cd = "z";

    a = "git add --patch";
    b = "git switch --create";
    c = "git commit";
    ca = "git commit --amend";
    cm = "git commit --message";
    dl = "http --download get";

    quit = "exit";

    neofetch = "fastfetch";
  };
in
{

  imports = [
    ./tmux.nix
    ./starship.nix
  ];
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = aliases;
    };
    # SHELL
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      enableVteIntegration = true;
      autocd = true;
      # dotDir = ".config/zsh";
      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreDups = true;
        path = "${config.xdg.dataHome}/zsh/history";

        save = 10000;
        share = true;
      };

      initExtra = ''
        # Keybindings
        bindkey '^H' backward-kill-word # Ctrl+Backspace
        bindkey '\e[1;5D' backward-word # Ctrl+Left
        bindkey '\e[1;5C' forward-word # Ctrl+Right
        bindkey '^Z' undo # Ctrl+Z

        # make nix-shell use zsh
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh | source /dev/stdin


        # check if already inside a tmux session
        if [ -z "$TMUX" ]; then
        # atach to tmux session if exists, else create a new one
        ${pkgs.tmux}/bin/tmux attach -t default || ${pkgs.tmux}/bin/tmux new -s default
        fi
      '';

      shellAliases = aliases;

      plugins = [
        {
          # https://github.com/hlissner/zsh-autopair
          name = "zsh-autopair";
          file = "zsh-autopair.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
            sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
          };
        }
        {
          # https://github.com/zsh-users/zsh-history-substring-search
          name = "zsh-history-substring-search";
          file = "zsh-history-substring-search.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-history-substring-search";
            rev = "0f80b8eb3368b46e5e573c1d91ae69eb095db3fb";
            sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
          };
        }
        {
          name = "zsh-autosuggestions";
          file = "zsh-autosuggestions.plugin.zsh";
          src = builtins.fetchGit {
            url = "https://github.com/zsh-users/zsh-autosuggestions";
            rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
          };
        }
      ];
    };

  };

  home.packages = with pkgs; [
    fastfetch
    disfetch
    onefetch
    gnugrep
    gnused
    bat
    eza
    bottom
    direnv
    nix-direnv
    nh
  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
