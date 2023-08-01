require('catppuccin').setup({
    flavour = 'mocha',
    integrations = {
        nvimtree = true
    }
})

require('lualine').setup({
    options = {
        theme = 'catppuccin'
    }
})

vim.cmd.colorscheme 'catppuccin'
