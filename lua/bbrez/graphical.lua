vim.o.guifont = 'CaskaydiaCove NF SemiLight'
vim.g.neovide_refresh_rate = 144

local function file_exists(file)
  local f = io.open(file, 'rb')
  if f then
    f:close()
  end
  return f ~= nil
end

local function create_config_file(file, content)
  local dir = vim.fn.fnamemodify(file, ':h')
  vim.fn.mkdir(dir, 'p')
  local f = io.open(file, 'w')
  if f then
    f:write(content)
    f:close()
  end
end

-- Only written when the file does not already exist.
local config_content = [[
[font]
normal = ["CaskaydiaCove NF SemiLight"]
bold = ["CaskaydiaCove NF"]
italic = ["CaskaydiaCove NF SemiLight Italic"]
bold_italic = ["CaskaydiaCove NF Italic"]
size = 12

[font.features]
"CaskaydiaCove NF SemiLight" = ["+liga", "+calt", "+ss01", "+ss19", "+ss20"]
]]

local is_windows = vim.fn.has('win32') == 1
local neovide_config_path

if is_windows then
  neovide_config_path = os.getenv('AppData') .. '/neovide/config.toml'
else
  local xdg = os.getenv('XDG_CONFIG_HOME') or (os.getenv('HOME') .. '/.config')
  neovide_config_path = xdg .. '/neovide/config.toml'
end

if not file_exists(neovide_config_path) then
  create_config_file(neovide_config_path, config_content)
end
