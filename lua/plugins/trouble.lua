return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'TroubleToggle',
  init = function()
    vim.keymap.set('n', '<leader>cd', ':TroubleToggle document_diagnostics<CR>', {
      noremap = true,
      silent = true,
      desc = 'Code Diagnostics',
    })

    vim.keymap.set('n', '<leader>ca', ':TroubleToggle quickfix<CR>', {
      noremap = true,
      silent = true,
      desc = 'Code Action',
    })
  end,
}
