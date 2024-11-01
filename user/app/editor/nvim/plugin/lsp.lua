local lspconfig = require('lspconfig')
lspconfig.nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" }, -- or nixfmt or nixpkgs-fmt
      },
      options = {
        nixos = {
            expr = '(builtins.getFlake "/home/andre/dotfiles/nixos").nixosConfigurations.system.options',
        },
        home_manager = {
            expr = '(builtins.getFlake "/home/andre/dotfiles/nixos").homeConfigurations.user.options',
        },
      },
    },
  },
})