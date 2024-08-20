return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    {
      '<leader>cd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Code Diagnostics',
      noremap = true,
      silent = true,
    },

    {
      '<leader>ca',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Code Action',
      noremap = true,
      silent = true,
    }
  },
}
