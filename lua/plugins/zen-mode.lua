return {
  'folke/zen-mode.nvim',
  lazy = true,
  cmd = 'ZenMode',
  init = function()
    vim.keymap.set('n', '<leader>vz', ':ZenMode<CR>', {
      noremap = true,
      silent = true,
      desc = 'Toggle Zen Mode'
    })
  end,
}
