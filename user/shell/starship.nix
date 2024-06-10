{pkgs, ...}:{

      # SHELL CUSTOMIZATION
    programs.starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;

        add_newline = false;
        # format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
        # shlvl = {
        #   disabled = false;
        #   symbol = "ﰬ";
        #   style = "bright-red bold";
        # };
        shell = {
          disabled = false;
          format = "$indicator";
          bash_indicator = "[BASH](bright-white)";
          zsh_indicator = "";
        };
        username = {
          style_user = "bright-white bold";
          style_root = "bright-red bold";
        };
        hostname = {
          style = "bright-green bold";
          ssh_only = true;
        };
        nix_shell = {
          symbol = "";
          format = "[$symbol$name]($style) ";
          style = "bright-purple bold";
        };
        git_branch = {
          only_attached = true;
          symbol = " ";
          style = "bright-yellow bold";
        };
        git_status = {
          ahead = "";
          behind = "";
          diverged = "";
        };

        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
}