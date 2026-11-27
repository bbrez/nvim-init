return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  opts = {},
  keys = {
    { '<leader>ct', '<cmd>TodoTrouble<cr>', desc = 'Todo Trouble' },
    { '<leader>fT', '<cmd>TodoTelescope<cr>', desc = 'Todo Telescope' },
  },
}
