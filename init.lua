require('bbrez.set')
require('bbrez.remap')
require('bbrez.lazy')

if vim.g.neovide then
  require('bbrez.graphical')
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    local ok, tree_sitter = pcall(require, 'nvim-treesitter')
    if not ok then
      return
    end

    local filetype = vim.bo.filetype
    if not filetype or filetype == '' then
      return
    end

    local lang = vim.treesitter.language.get_lang(filetype)
    if not lang or not vim.tbl_contains(tree_sitter.get_installed(), lang) then
      return
    end

    vim.treesitter.start()
  end,
})
