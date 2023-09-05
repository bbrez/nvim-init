require('catppuccin').setup({
    flavour = 'mocha',
    integrations = {
        nvimtree = true
    }
})

local is_windows = vim.fn.has('win32') == 1

if is_windows then
    vim.cmd.colorscheme 'catppuccin'

    require('lualine').setup({
        options = {
            theme = 'catppuccin'
        }
    })
else
    vim.cmd.colorscheme 'kanagawa'
    require('lualine').setup({
        options = {
            theme = 'kanagawa'
        }
    })
end
