return {
  'folke/twilight.nvim',
  lazy = true,
  cmd = { 'Twilight' },
  init = function()
    vim.keymap.set('n', '<leader>vt', ':Twilight<CR>', {
      noremap = true,
      silent = true,
      desc = 'Toggle Twilight Mode',
    })
  end
}
