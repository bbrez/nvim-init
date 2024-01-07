return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  cmd = 'NvimTreeToggle',

  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.keymap.set('n', '<leader>ft', ':NvimTreeToggle<CR>', {
      noremap = true,
      silent = true,
      desc = 'Toggle File Tree'
    })
  end,

  config = function()
    require('nvim-tree').setup()
  end,
}
