return {
  'famiu/bufdelete.nvim',
  init = function()
    vim.keymap.set('n', '<leader>fc', ':Bdelete<CR>', {
      noremap = true,
      silent = true,
      desc = 'Close File'
    })

    vim.keymap.set('n', '<leader>fC', ':Bdelete!<CR>', {
      noremap = true,
      silent = true,
      desc = 'Force Close File'
    })
  end,
}
