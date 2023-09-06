local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

lsp.extend_cmp()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end
    }
})

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
})
