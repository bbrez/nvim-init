vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.numberwidth = 2

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true

local is_windows = vim.fn.has('win32') == 1

if is_windows then
  vim.opt.undodir = os.getenv('USERPROFILE') .. '\\.vim\\undodir'
else
  vim.opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undodir'
end
