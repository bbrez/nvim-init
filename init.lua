require('bbrez.set')
require('bbrez.remap')
require('bbrez.lazy')

if vim.g.neovim then
  require('bbrez.graphical')
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    local tree_sitter = require'nvim-treesitter'

    local filetype = vim.bo.filetype
    if not filetype or filetype == '' then
      return
    end

    local lang = vim.treesitter.language.get_lang(filetype)
    if not lang or not vim.tbl_contains(tree_sitter.get_installed(), lang) then
      return
    end

    vim.treesitter.start()
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

