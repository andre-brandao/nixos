{
  pkgs,
  nixvim,
  systemSettings,
  ...
}: {
  environment.systemModules = [
    (nixvim.legacyPackages."${systemSettings.system}".makeNixvim {
      colorschemes.gruvbox.enable = true;

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
      };
    })
  ];
}
