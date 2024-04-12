{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # nixpkgs = {
  #   overlays = [
  #     (final: prev: {
  #       vimPlugins = prev.vimPlugins // {
  #         own-onedark-nvim = prev.vimUtils.buildVimPlugin {
  #           name = "onedark";
  #           src = inputs.plugin-onedark;
  #         };
  #       };
  #     })
  #   ];
  # };

  programs.neovim =
    let
      toLua = str: ''
        lua << EOF
        ${str}
        EOF
      '';
      toLuaFile = file: ''
        lua << EOF
        ${builtins.readFile file}
        EOF
      '';
    in
    {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = ''
        set number relativenumber
        set shiftwidth=2
        set tabstop=2
        set expandtab
        set autoindent
        set smartindent
        set smarttab

        set scrolloff=8


      '';

      extraPackages = with pkgs; [
        lua-language-server
        # rnix-lsp
        nil
        nixd

        typescript
        nodePackages.typescript-language-server
        # nodePackages.\@astrojs/language-server

        marksman
        rust-analyzer
        yaml-language-server

        xclip
        wl-clipboard
      ];

      plugins = with pkgs.vimPlugins; [
        undotree
        vimfiler-vim

        {
          plugin = lsp-zero-nvim;
          config = toLuaFile ./plugin/zero-lsp.lua;
        }
        coc-eslint
        coc-tsserver
        # {
        #   plugin = nvim-lspconfig;
        #   config = toLuaFile ./plugin/lsp.lua;
        # }

        {
          plugin = comment-nvim;
          config = toLua ''require("Comment").setup()'';
        }

        {
          plugin = gruvbox-nvim;
          config = "colorscheme gruvbox";
        }

        neodev-nvim

        nvim-cmp
        {
          plugin = nvim-cmp;
          config = toLuaFile ./plugin/cmp.lua;
        }

        {
          plugin = telescope-nvim;
          config = toLuaFile ./plugin/telescope.lua;
        }

        telescope-fzf-native-nvim

        cmp_luasnip
        cmp-nvim-lsp
        cmp-path
        cmp-cmdline

        # mason
        # mason-lspconfig

        # fidget

        luasnip
        friendly-snippets

        lualine-nvim
        nvim-web-devicons

        {
          plugin = nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-javascript
            p.tree-sitter-typescript
            p.tree-sitter-yaml
            p.tree-sitter-markdown
            p.tree-sitter-toml
            p.tree-sitter-go
            p.tree-sitter-rust
          ]);
          config = toLuaFile ./plugin/treesitter.lua;
        }

        vim-nix

        # {
        #   plugin = vimPlugins.own-onedark-nvim;
        #   config = "colorscheme onedark";
        # }
      ];

      # ${builtins.readFile ./plugin/lsp.lua}
      # ${builtins.readFile ./plugin/cmp.lua}
      # ${builtins.readFile ./plugin/telescope.lua}
      # ${builtins.readFile ./plugin/treesitter.lua}

      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
        ${builtins.readFile ./plugin/other.lua}
      '';
    };
}
