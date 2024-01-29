return {
  'iamcco/markdown-preview.nvim',
  lazy = true,
  cmd = 'MarkdownPreviewToggle',
  ft = 'markdown',
  init = function()
    vim.keymap.set('n', '<leader>md', ':MarkdownPreviewToggle<CR>', {
      noremap = true,
      silent = true,
      desc = 'Markdown preview'
    })

    vim.g.mkdp_filetypes = { 'markdown' }
  end,

  build = 'cd app && npx --yes yarn install',
}
