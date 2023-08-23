local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end

    return false
end

local packer_bootstrap = ensure_packer()
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({ function(use)
    use 'wbthomason/packer.nvim'

    use { 'catppuccin/nvim', as = 'catppuccin' }

    use { 'rebelot/kanagawa.nvim' }

    use 'nvim-tree/nvim-tree.lua'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'dev-v3',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'}
        }
    }

    use 'github/copilot.vim'

    use {
        'akinsho/bufferline.nvim',
        tag = '*',
        requires = 'nvim-tree/nvim-web-devicons',
        after = 'catppuccin',
        config = function()
            require('bufferline').setup {
                highlights = require('catppuccin.groups.integrations.bufferline').get(),
                options = {
                    diagnostics = 'nvim_lsp',
                    separator_style = 'slant',
                    offsets = {{
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true
                    }},
                },
            }
        end
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup{}
        end
    }

    use 'lukas-reineke/indent-blankline.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        }
    }

    use {
        'nvim-lualine/lualine.nvim',
    }

    use {
        'akinsho/nvim-toggleterm.lua',
        config = function()
            require('toggleterm').setup{
                autochdir = true,
                open_mapping = [[<leader>tt]],
                insert_mappings = false,
                direction = 'float',
                float_opts =  {
                    border =  'curved',
                },
                shade_terminals = true,
                shading_factor = -30,
                winbar = {
                    enabled = true,
                    name_formatter = function(term)
                        return term.name
                    end
                }
            }
        end
    }

    use {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require('which-key')
            wk.setup{}
            wk.register({
                c = { name = 'Code' },
                f = { name = 'File' },
                t = { name = 'Terminal' },
            }, { prefix = '<leader>' })
        end
    }

    use {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    }

    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && npm install',
        setup = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
    }

    use {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup{}
        end
    }

    use 'famiu/bufdelete.nvim'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end,
config = {
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end,
    }
}})
