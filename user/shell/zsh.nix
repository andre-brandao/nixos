{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (builtins) readFile replaceStrings;
  inherit (lib) concatLines concatStringsSep genAttrs mapAttrsToList toShellVar;
  # palette = import ../resources/palette.nix { inherit lib; };
  # toAbbrs = kv: concatLines (mapAttrsToList (k: v: "abbr ${toShellVar k v}") kv);

  aliases = {
    ls = "eza --icons -l -T -L=1";
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";

    # ll = "ls -l";
    update = "sudo nixos-rebuild switch --flake ~/dotfiles/minimal";
    home-update = "home-manager switch ~/dotfiles/minimal#andre@nixos";

    a = "git add --patch";
    b = "git switch --create";
    c = "git commit";
    ca = "git commit --amend";
    cm = "git commit --message";
    d = "git diff ':!*.lock'";
    dl = "http --download get";
    ds = "git diff --staged ':!*.lock'";
    dsw = "git diff --staged --ignore-all-space ':!*.lock'";
    dw = "git diff --ignore-all-space ':!*.lock'";

    # ll = "eza -la";
    # pyclean = "find . | grep -E '(__pycache__|\.pyc|\.pyo$)' | xargs rm -rf";
    # pc = "pycharm-community . > /dev/null 2>&1 &";
  };
in {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = aliases;
    };

    # tmux = {
    #   enable = true;
    #   extraConfig = ''
    #     ...
    #     set -g status-right '#[fg=black,bg=color15] #{cpu_percentage}  %H:%M '
    #     run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
    #   '';
    # };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
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
        # make nix-shell use zsh
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh | source /dev/stdin

        #  atach to tmux
        # ${pkgs.tmux}/bin/tmux attach -t default || ${pkgs.tmux}/bin/tmux new -s default
      '';

      shellAliases = aliases;

      plugins = [
        {
          # https://github.com/softmoth/zsh-vim-mode
          name = "zsh-vim-mode";
          file = "zsh-vim-mode.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "softmoth";
            repo = "zsh-vim-mode";
            rev = "abef0c0c03506009b56bb94260f846163c4f287a";
            sha256 = "0cnjazclz1kyi13m078ca2v6l8pg4y8jjrry6mkvszd383dx1wib";
          };
        }
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
      ];
    };
  };

  home.file.".p10k.zsh".source = ./p10k.zsh;
  home.packages = with pkgs; [
    disfetch
    lolcat
    cowsay
    onefetch
    gnugrep
    gnused
    bat
    eza
    bottom
    fd
    bc
    direnv
    nix-direnv
  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
