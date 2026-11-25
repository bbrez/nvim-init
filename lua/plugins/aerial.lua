return {
  'stevearc/aerial.nvim',
  lazy = true,
  cmd = 'AerialToggle',
  opts = {
    layout = {
      width = 30,
      default_direction = 'right',
    },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>co',
      '<cmd>AerialToggle<cr>',
      desc = 'Toggle Code Outline',
    },
  },
}
