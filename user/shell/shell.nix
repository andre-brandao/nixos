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
    # user-update = "nh home switch ${userSettings.configDir} -c user";

    lss = "eza --icons -l -T -L=1";
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

    ndev = "nix develop";
    nshell = "nix-shell";

    quit = "exit";

    neofetch = "fastfetch";
    type-br = "${lib.getExe pkgs.typer} -m --monkeytype-language portuguese";
  };
in
{

  imports = [
    ./tmux.nix
    ./starship.nix
    # ./oh-my-posh.nix
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
      # autosuggestion.enable = true;

      # enableCompletion = true;
      # syntaxHighlighting.enable = true;
      # enableVteIntegration = true;
      # autocd = true;
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
        bindkey "''${key[Up]}" up-line-or-search


        # # check if already inside a tmux session
        # if [ -z "$TMUX" ]; then
        # # atach to tmux session if exists, else create a new one
        # ${pkgs.tmux}/bin/tmux attach -t default || ${pkgs.tmux}/bin/tmux new -s default
        # fi

        # make nix-shell use zsh
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      '';

      shellAliases = aliases;

      # zplug = {
      #   enable = true;
      #   plugins = [
      #     { name = "zsh-users/zsh-autosuggestions"; }
      #     { name = "zsh-users/zsh-syntax-highlighting"; }
      #     { name = "zsh-users/zsh-completions";}

      #     { name = "marlonrichert/zsh-autocomplete"; }
      #     { name = "chisui/zsh-nix-shell"; }
      #     { name = "ptavares/zsh-direnv"; }

      #     # { name = "zdharma-continuum/fast-syntax-highlighting"; }
      #     # { name = "zsh-users/zsh-history-substring-search"; }
      #   ];
      # };
      antidote = {
        enable = true;
        plugins = [
          "zsh-users/zsh-completions"
          "zsh-users/zsh-syntax-highlighting"
          "zsh-users/zsh-autosuggestions"

          "ptavares/zsh-direnv"
          "chisui/zsh-nix-shell"
          # "marlonrichert/zsh-autocomplete"
        ];
      };
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
