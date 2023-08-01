require('catppuccin').setup({
    flavour = 'mocha',
    integrations = {
        nvimtree = true
    }
})

vim.cmd.colorscheme 'catppuccin'
