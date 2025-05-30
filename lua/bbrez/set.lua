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

vim.api.nvim_create_augroup("IndentSettings", {clear = true})
local function set_indent(filetypes, tabstop, shiftwidth, expandtab)
  for _, ft in ipairs(filetypes) do
    vim.api.nvim_create_autocmd("FileType", {
      group = "IndentSettings",
      pattern = ft,
      callback = function()
        vim.bo.tabstop = tabstop
        vim.bo.shiftwidth = shiftwidth
        vim.bo.softtabstop = tabstop
        vim.bo.expandtab = expandtab
      end
    })
  end
end

set_indent({"cshtml", "cs"}, 4, 4, true)

vim.filetype.add({
  extension = {
    cshtml = "razor"
  }
})

local is_windows = vim.fn.has('win32') == 1

if is_windows then
  vim.opt.undodir = os.getenv('USERPROFILE') .. '\\.vim\\undodir'
  vim.o.shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
  vim.o.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues["Out-File:Encoding"]="utf8";Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
  vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.o.shellpipe = '2>&1 | %{ "$_" } | tee %s; exit $LastExitCode'
  vim.o.shellquote = ''
  vim.o.shellxquote = ''
else
  vim.opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undodir'
end
