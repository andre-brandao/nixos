{ pkgs-unstable, ... }:
let
  pkgs = pkgs-unstable;
in
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
      # theme = "transparentize";
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
    languages = {
      language-server = {
        astro-ls = {
          command = "${pkgs.nodePackages."@astrojs/language-server"}/bin/astro-ls";
          args = [ "--stdio" ];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          language-servers = [ "nixd" ];
        }
        {
          name = "python";
          auto-format = true;
        }
        {
          name = "javascript";
          auto-format = true;
        }
        {
          name = "typescript";
          auto-format = true;
        }
        {
          name = "json";
          auto-format = true;
        }
        {
          name = "yaml";
          auto-format = true;
        }
        {
          name = "html";
          auto-format = true;
        }
        {
          name = "css";
          auto-format = true;
        }
        {
          name = "astro";
          auto-format = true;
          language-servers = [ "astro-ls" ];
        }
        {
          name = "svelte";
          auto-format = true;
          language-servers = [ "svelteserver" ];
        }
        {
          name = "elixir";
          auto-format = true;
          language-servers = [ "elixir-ls" ];
        }
        {
          name = "markdown";
          auto-format = true;
          language-servers = [ "marksman" ];
        }
        {
          name = "go";
          auto-format = true;
          formatter = {
            command = "goimports";
          };
        }
      ];
    };
    # ***** LSP packages *****
    extraPackages =
      with pkgs;
      with nodePackages;
      [
        bash-language-server # BASH
        lldb # debugger
        marksman # Markdown

        elixir_ls # Elixir

        # # NIX
        # nixpkgs-fmt:
        nil
        # GO
        gopls
        gotools

        # C/C++
        clang-tools
        lua-language-server
        # RUST
        rust-analyzer

        # PYTHON
        pyright
        (python3.withPackages (
          ps: with ps; [ python-lsp-server ] ++ python-lsp-server.optional-dependencies.all
        ))

        # JAVASCRIPT AND CIA
        typescript
        # vscode-langservers-extracted
        typescript-language-server
        svelte-language-server
        yaml-language-server
        stylelint

        nodePackages."@astrojs/language-server"

        dockerfile-language-server-nodejs
      ];
  };
}
