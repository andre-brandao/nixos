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
in {
  programs = {
    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };

      # shellIntegration.enableFishIntegration = true;
      theme = "Catppuccin-Macchiato";
    };
    # zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   enableAutosuggestions = true;
    #   # syntaxHighlighting.enable = true;

    #   shellAliases = {
    #     ll = "ls -l";
    #     update = "sudo nixos-rebuild switch --flake ~/.dotfiles/minimal";
    #     home-update = "home-manager switch /home/andre/.dotfiles/minimal#andre@nixos";

    #     a = "git add --patch";
    #     b = "git switch --create";
    #     c = "git commit";
    #     ca = "git commit --amend";
    #     cm = "git commit --message";
    #     d = "git diff ':!*.lock'";
    #     dl = "http --download get";
    #     ds = "git diff --staged ':!*.lock'";
    #     dsw = "git diff --staged --ignore-all-space ':!*.lock'";
    #     dw = "git diff --ignore-all-space ':!*.lock'";
    #     # hs = "home-manager switch";
    #     rebase = "git rebase --autostash --autosquash --interactive";
    #     s = "git status";
    #   };
    #   history = {
    #     size = 1000000;
    #     path = "${config.xdg.dataHome}/zsh/history";
    #   };
    #   initExtraBeforeCompInit = with pkgs; ''
    #     # Powerlevel10k instant prompt
    #     if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
    #       source "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
    #     fi

    #     # Completions
    #     fpath+=(${zsh-completions}/src)
    #   '';

    #   initExtra =
    #     replaceStrings [
    #       # "@zsh-abbr@"
    #       # "@zsh-click@"
    #       "@zsh-powerlevel10k@"
    #       "@zsh-prezto-terminal@"
    #       "@zsh-syntax-highlighting@"
    #     ] (with pkgs; [
    #       # "${zsh-abbr}/share/zsh/plugins/zsh-abbr/zsh-abbr.plugin.zsh"
    #       # "${zsh-click}/share/zsh/plugins/click/click.plugin.zsh"
    #       "${zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
    #       "${zsh-prezto}/share/zsh-prezto/modules/terminal/init.zsh"
    #       "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    #     ]) (readFile ./init-extra.zsh);
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
      '';

      shellAliases = {
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

        cat = "bat";
        # ll = "eza -la";
        # pyclean = "find . | grep -E '(__pycache__|\.pyc|\.pyo$)' | xargs rm -rf";
        # pc = "pycharm-community . > /dev/null 2>&1 &";
      };

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
}
