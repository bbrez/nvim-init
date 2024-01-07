return {
  'folke/which-key.nvim',
  --event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require('which-key')
    wk.setup{}
    wk.register({
      c = { name = 'Code' },
      f = { name = 'File' },
      t = { name = 'Terminal' },
      v = { name = 'View' },
      w = { name = 'Window' },
    }, { prefix = '<leader>' })
  end,
}
