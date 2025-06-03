require('bbrez.set')
require('bbrez.remap')
require('bbrez.lazy')

if vim.g.neovim then
  require('bbrez.graphical')
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    local tree_sitter = require'nvim-treesitter'

    for _, lang in ipairs(tree_sitter.get_installed()) do
      if vim.bo.filetype and lang == vim.treesitter.language.get_lang(vim.bo.filetype) then
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end
  end,
})

