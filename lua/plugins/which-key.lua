return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    'echasnovski/mini.icons',
    'nvim-tree/nvim-web-devicons'
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require('which-key')
    wk.add({
      {"<leader>c", group = "Code"},
      {"<leader>f", group = "File"},
      {"<leader>t", group = "Terminal"},
      {"<leader>v", group = "View"},
      {"<leader>w", group = "Window"}
    })
  end
}
