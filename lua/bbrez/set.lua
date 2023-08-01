vim.opt.termguicolors = true

vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

local is_windows = vim.fn.has('win32') == 1

if is_windows then
    vim.opt.undodir = os.getenv('USERPROFILE') .. '\\.vim\\undodir'
else
    vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
end

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.colorcolumn = '80'
