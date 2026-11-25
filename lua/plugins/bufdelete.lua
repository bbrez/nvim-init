return {
  'famiu/bufdelete.nvim',
  keys = {
    {
      '<leader>fc',
      '<cmd>Bdelete<cr>',
      desc = 'Close File',
    },
    {
      '<leader>fC',
      '<cmd>Bdelete!<cr>',
      desc = 'Force Close File',
    },
  },
}
