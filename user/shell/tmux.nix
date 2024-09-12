{ pkgs, config, ... }:
{
  programs = {

    # MULTIPLEXER
    tmux = {
      enable = true;
      clock24 = true;

      plugins = with pkgs.tmuxPlugins; [
        better-mouse-mode
        # catppuccin
        resurrect
        yank
      ];
      sensibleOnTop = false;
      disableConfirmationPrompt = true;
      extraConfig =
        let
          color1 = "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base08}";

          color2 = "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A}";

          color3 = "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0B}";

          background = "${config.lib.stylix.colors.base00}";
          foreground = "${config.lib.stylix.colors.base0D}";
        in
        ''

          # keyMode = "vi";

          # set -g @catppuccin_flavour 'frappe'
          # set -g @catppuccin_window_tabs_enabled on
          # set -g @catppuccin_date_time "%H:%M"

          # Mouse works as expected
          set -g mouse on



          # start tab index at 1
          set -g base-index 1
          set -g pane-base-index 1
          set-window-option -g pane-base-index 1
          set-option -g renumber-windows on

          # AUTOMATIC REMANE
          setw -g automatic-rename on

          # open new panes in current dir
          bind '"' split-window -v -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          # new bind for horizontal split
          bind-key "|" split-window -h -c "#{pane_current_path}"
          bind-key "\\" split-window -fh -c "#{pane_current_path}"
          # new bind for vertical split
          bind-key "-" split-window -v -c "#{pane_current_path}"
          bind-key "_" split-window -fv -c "#{pane_current_path}"


          # reload tmux config with prefix + r
          bind r source-file ~/.config/tmux/tmux.conf # \; display "Reloaded! .config/tmux/tmux.conf"


          # set prefix to C-Space
          unbind C-Space
          set -g prefix C-Space
          bind C-Space send-prefix


          # STATUS BAR


          set -g status-right ' #[${color1}]  : #{cpu_percentage} #[${color2}] %H:%M | %d-%m-%Y '
          set -g status-left '#[${color3}] 󱄅 '
          set -g status-bg '#${background}'
          set -g status-fg '#${foreground}'

          # set-option -g status-position top



          run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
        '';
    };
  };
}
