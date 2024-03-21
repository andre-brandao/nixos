{
  config,
  pkgs,
  inputs,
  ...
}: {
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

  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
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

      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = lsp-zero-nvim;
        config = toLuaFile ./plugin/zero-lsp.lua;
      }

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
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
        ]);
        config = toLuaFile ./plugin/treesitter.lua;
      }

      vim-nix

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];

     extraLuaConfig = ''
     ${builtins.readFile ./options.lua}
     -- ${builtins.readFile ./plugin/lsp.lua}
     ${builtins.readFile ./plugin/cmp.lua}
     ${builtins.readFile ./plugin/telescope.lua}
     ${builtins.readFile ./plugin/treesitter.lua}
     ${builtins.readFile ./plugin/other.lua}
     ${builtins.readFile ./plugin/zero-lsp.lua}
     '';
  };
}
