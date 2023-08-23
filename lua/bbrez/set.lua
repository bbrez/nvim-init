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

vim.opt.splitright = true
vim.opt.splitbelow = true

local is_windows = vim.fn.has('win32') == 1

if is_windows then
    vim.opt.undodir = os.getenv('USERPROFILE') .. '\\.vim\\undodir'

    local powershell_options = {
        shell = 'pwsh',
        shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
        shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
        shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
        shellquote = "",
        shellxquote = "",
    }

    for option, value in pairs(powershell_options) do
        vim.opt[option] = value
    end
else
    vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
end

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.colorcolumn = '80'
