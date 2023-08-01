local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

lsp.extend_cmp()

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
        end
    }
})

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true
    },
})
