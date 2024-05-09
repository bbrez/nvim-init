return {
  'stevearc/aerial.nvim',
  lazy = true,
  cmd = "AerialToggle",
  opts = {
    layout = {
      width = 30,
      default_direction = 'right',
    }
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons'
  },

  init = function()
    vim.keymap.set('n', '<leader>co', ':AerialToggle<CR>', {
      noremap = true,
      silent = true,
      desc = 'Toggle Code Outline'
    })
  end,
}
