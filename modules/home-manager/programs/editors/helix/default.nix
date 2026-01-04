{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    themes = {
      transparentize = {
        # THEME TO BE USED WITHOU BG
        "inherits" = "adwaita-dark"; # jellybeans tokyonight
        "ui.background" = { };
      };
    };
    settings = {
      theme = "transparentize";
      editor = {
        scrolloff = 8;

        line-number = "relative";
        auto-format = true;
        auto-completion = true;
        idle-timeout = 200;

        bufferline = "multiple";

        color-modes = true;

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        # rainbow-brackets = true;

        statusline = {
          # mode-separator = "";
          separator = "";
          # mode-separator = "";
          # separator = "";
          # separator = "";
          left = [
            "mode"
            "spinner"
            "diagnostics"

            "file-modification-indicator"
            "read-only-indicator"
          ];
          center = [
            "version-control"
            "spacer"
            "separator"
            "file-name"
          ];
          right = [
            # "file-encoding"
            # "file-line-ending"
            "selections"
            # "register"
            "file-type"
            # "separator"
            "position-percentage"
            "position"
          ];
          mode = {
            # 󱄅 
            normal = " NOR   ";
            insert = "    INS";
            select = "󰈈 SELECT";
          };
        };

        whitespace = {
          render = "all";
          characters = {
            # space = "·";
            space = " ";
            nbsp = "⍽";
            tab = "→";
            newline = "⤶";
          };
        };
        indent-guides = {
          render = true;
          character = "┊";
        };
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
        "C-g" = [
          ":new"
          ":insert-output lazygit"
          ":buffer-close!"
          ":redraw"
        ];

      };
    };
  };
}
