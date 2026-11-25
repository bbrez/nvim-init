return {
  'iamcco/markdown-preview.nvim',
  lazy = true,
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = 'markdown',
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  keys = {
    {
      '<leader>md',
      '<cmd>MarkdownPreviewToggle<cr>',
      desc = 'Markdown preview',
    },
  },
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
}
