return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    {
      '<leader>cd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Code Diagnostics',
    },
    {
      '<leader>cq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix',
    },
  },
}
