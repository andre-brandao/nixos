-- Lualine
require("lualine").setup({
    icons_enabled = true,
    theme = 'onedark',

})

-- Colorscheme
vim.cmd("colorscheme gruvbox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


-- Comment
require("Comment").setup()
