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

    -- Only auto-quit when the tree is the last window *and* there are no
    -- other listed buffers. Otherwise opening another buffer (e.g. after
    -- closing a terminal) would leave only the tree and exit Neovim.
    vim.api.nvim_create_autocmd('BufEnter', {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() ~= 1 then
          return
        end
        if not require('nvim-tree.utils').is_nvim_tree_buf() then
          return
        end

        local tree_buf = vim.api.nvim_get_current_buf()
        local alternate
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if buf ~= tree_buf
            and vim.api.nvim_buf_is_valid(buf)
            and vim.bo[buf].buflisted
          then
            alternate = buf
            break
          end
        end

        if alternate then
          vim.api.nvim_win_set_buf(0, alternate)
        else
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
