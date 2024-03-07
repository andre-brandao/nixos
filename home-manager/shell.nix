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
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      # syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake ~/.dotfiles/minimal";
        home-update = "home-manager switch /home/andre/.dotfiles/minimal#andre@nixos";

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
        # hs = "home-manager switch";
        rebase = "git rebase --autostash --autosquash --interactive";
        s = "git status";
      };
      history = {
        size = 1000000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      initExtraBeforeCompInit = with pkgs; ''
        # Powerlevel10k instant prompt
        if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi

        # Completions
        fpath+=(${zsh-completions}/src)
      '';

      initExtra =
        replaceStrings [
          # "@zsh-abbr@"
          # "@zsh-click@"
          "@zsh-powerlevel10k@"
          "@zsh-prezto-terminal@"
          "@zsh-syntax-highlighting@"
        ] (with pkgs; [
          # "${zsh-abbr}/share/zsh/plugins/zsh-abbr/zsh-abbr.plugin.zsh"
          # "${zsh-click}/share/zsh/plugins/click/click.plugin.zsh"
          "${zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
          "${zsh-prezto}/share/zsh-prezto/modules/terminal/init.zsh"
          "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        ]) (readFile ./init-extra.zsh);
    };
  };

  home.file.".p10k.zsh".source = ./p10k.zsh;
}
