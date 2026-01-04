{
  inputs,
  lib,
  config,
  pkgs,
  settings,
  ...
}:
let
  aliases = {
    sys-update = "nh os switch ${settings.configDir}  -H xps";

    zed = "zeditor";

    lss = "eza --icons -l -T -L=1";
    fd = "fd -Lu";
    wpp = "${lib.getExe pkgs.waypaper} --backend swww --folder ~/Pictures/Wallpapers";
    # c = "git commit";
    # ca = "git commit --amend";
    cm = "git commit --message";
    # a = "git add --patch";
    # b = "git switch --create";
    # dl = "http --download get";

    k = "kubectl";
    l = "eza -l";

    ndev = "nix develop";
    nshell = "nix-shell";
    neval = "nix-instantiate --strict --eval";

    quit = "exit";
    spf = "${lib.getExe pkgs.unstable.superfile}";
    hyprlogs = "tail -f $XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/hyprland.log";
    type-br = "${lib.getExe pkgs.typer} -m --monkeytype-language portuguese";
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
      # shellAliases = aliases;
    };
    # SHELL
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      autocd = true;
      # autosuggestion.enable = true;
      # enableCompletion = true;
      # syntaxHighlighting.enable = true;
      # enableVteIntegration = true;
      # autocd = true;
      # dotDir = ".config/zsh";
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        path = "${config.xdg.dataHome}/zsh/history";
        # share = true;
      };

      initContent = ''
        autoload -U history-search-end
        zle -N history-beginning-search-backward-end history-search-end
        zle -N history-beginning-search-forward-end history-search-end

        # Keybindings
        bindkey "^[OA" history-beginning-search-backward-end
        bindkey "^[OB" history-beginning-search-forward-end

        # C-right / C-left for word skips
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word

        # C-Backspace / C-Delete for word deletions
        bindkey "^[[3;5~" forward-kill-word
        bindkey "^H" backward-kill-word


        # Home/End
        bindkey "^[[OH" beginning-of-line
        bindkey "^[[OF" end-of-line


        # open commands in $EDITOR with C-e
        autoload -z edit-command-line
        zle -N edit-command-line
        bindkey "^e" edit-command-line

        # case insensitive tab completion
        zstyle ':completion:*' completer _complete _ignored _approximate
        zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
        zstyle ':completion:*' verbose true

        # use cache for completions
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
        _comp_options+=(globdots)

        bindkey '^Z' undo # Ctrl+Z


        # make nix-shell use zsh
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      '';

      shellAliases = aliases;
      # antidote = {
      #   enable = true;
      #   plugins = [
      #     "zsh-users/zsh-completions"
      #     "zsh-users/zsh-syntax-highlighting"
      #     "zsh-users/zsh-autosuggestions"
      #     # "ptavares/zsh-direnv"
      #     # "chisui/zsh-nix-shell"
      #     # "marlonrichert/zsh-autocomplete"
      #   ];
      # };
    };
  };

  home.packages = with pkgs; [
    zip
    unzip
    unrar

    # fastfetch
    # disfetch
    # onefetch
    gnugrep
    gnused
    bat
    eza
    # devenv
  ];

}
