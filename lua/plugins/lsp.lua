return {
  'mason-org/mason-lspconfig.nvim',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
  },

  init = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local buf = event.buf
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = buf,
            silent = true,
            desc = desc,
          })
        end

        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { bufnr = buf })
        end

        map('n', 'K', vim.lsp.buf.hover, 'Hover')
        map('n', '<leader>ch', vim.lsp.buf.hover, 'Code Hover')

        map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
        map('n', 'go', vim.lsp.buf.type_definition, 'Go to type definition')
        map('n', 'gr', vim.lsp.buf.references, 'References')
        map('n', 'gs', vim.lsp.buf.signature_help, 'Signature help')

        map('n', '<F2>', vim.lsp.buf.rename, 'Rename')
        map('n', '<leader>cr', vim.lsp.buf.rename, 'Code Rename')

        map({ 'n', 'x' }, '<F3>', function()
          vim.lsp.buf.format({ async = true })
        end, 'Format')
        map('n', '<leader>cf', function()
          vim.lsp.buf.format({ async = true })
        end, 'Code Format')

        map('n', '<F4>', vim.lsp.buf.code_action, 'Code Action')
        map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')

        map('n', '<leader>ce', vim.diagnostic.open_float, 'Line Diagnostics')

        if vim.lsp.inlay_hint then
          map('n', '<leader>ci', function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
          end, 'Toggle Inlay Hints')
        end
      end,
    })
  end,

  config = function()
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.lsp.config('*', {
      capabilities = lsp_capabilities,
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = {
            library = { vim.env.VIMRUNTIME },
          },
        },
      },
    })

    require('mason-lspconfig').setup({
      ensure_installed = {},
      automatic_enable = true,
    })

    local cmp = require('cmp')

    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmd = { 'Man', '!' },
          },
        },
      }),
    })
  end,
}
