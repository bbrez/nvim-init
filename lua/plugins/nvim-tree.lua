return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  cmd = 'NvimTreeToggle',
  keys = {
    {
      '<leader>ft',
      '<cmd>NvimTreeToggle<cr>',
      desc = 'Toggle File Tree',
    },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.api.nvim_create_autocmd('BufEnter', {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and require('nvim-tree.utils').is_nvim_tree_buf() then
          vim.cmd('quit')
        end
      end,
    })
  end,
  config = function()
    require('nvim-tree').setup({
      view = {
        side = 'right',
      },
    })
  end,
}
