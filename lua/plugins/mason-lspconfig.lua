return {
  'williamboman/mason-lspconfig.nvim',
  opts = true,
  init = function()
    require('mason-lspconfig').setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup({})
      end,

      ['lua_ls'] = function()
         require('lspconfig').lua_ls.setup({
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT"
              },

              diagnostics = {
                globals = { 'vim' }
              },

              workspace = {
                library = {
                  vim.env.VIMRUNTIME
                }
              }
            }
          }
        })
      end,
    }
  end,
}
