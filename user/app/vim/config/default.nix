{
  # Import all your configuration modules here
  imports = [
    ./bufferline.nix
  ];

  plugins = {
    lualine.enable = true;
    telescope.enable = true;
    treesitter.enable = true;

    lsp = {
      enable = true;
      servers = {
        tsserver.enable = true;
        lua-ls.enable = true;
      };
    };

    # nvim-cmp = {
    #   enable = true;
    #   # autoEnableSources = true;
    #   sources = [
    #     {name = "nvim_lsp";}
    #     {name = "path";}
    #     {name = "buffer";}
    #   ];
    # };
  };
}
