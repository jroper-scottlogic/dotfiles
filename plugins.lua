-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    --generally useful
    use 'nvim-treesitter/nvim-treesitter' --mainly for syntax highlighting
    
    use 'nvim-lua/plenary.nvim' --useful lua commands

    use 'kyazdani42/nvim-web-devicons' --nerdfont symbols
    --ui
    
    use 'sainnhe/gruvbox-material' --set up in init, softer and with treesitter

    use {
        'nvim-lualine/lualine.nvim', --nice bar at bottom
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }, --icons
        config = function() require('lualine').setup() end
    }

    use {
        'lukas-reineke/indent-blankline.nvim', --gives vertical lines to show level
        config = function() require('indent_blankline').setup() end
    }

    use {
        'akinsho/bufferline.nvim', --makes tabs at the top
        tag = 'v3.*',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    use {
        'm-demare/hlargs.nvim', --highlight arguments in functions
        requires = 'nvim-treesitter/nvim-treesitter',
    }

    use {
        'NvChad/nvim-colorizer.lua', --#red #blue #green
        config = function() require('colorizer').setup() end
    }

    use 'HiPhish/nvim-ts-rainbow2' --rainbow highlighting for parentheses
    
    use 'RRethy/vim-illuminate'  --highlight other uses of word under cursor
    

    --LSP
    use {
        'williamboman/mason.nvim', --lovely lsp/dap etc manager
        'williamboman/mason-lspconfig.nvim', --bridge the gap, extra functionality
        'neovim/nvim-lspconfig', --lsp config client
        'jose-elias-alvarez/null-ls.nvim', --linters & formatters
        --completion engine
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        --snippets
        'L3MON4D3/LuaSnip',
    }

    use {
        'VonHeikemen/lsp-zero.nvim', --default configs for lsp setup
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }

    --Git
    use 'tpope/vim-fugitive' --git integration, non lua bassed

    use {
        'lewis6991/gitsigns.nvim', --give git info on line
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    }
    --utility
    use {
        'folke/which-key.nvim', --displays current commands in n mode
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup()
        end
    }

    use {
        'numToStr/Comment.nvim', --quick comments using gcc and gbc
        config = function() require('Comment').setup() end
    }

    use {
        'kylechui/nvim-surround', --change surrounders ys ds cs
        config = function() require('nvim-surround').setup() end
    }

    use {
        'tummetott/unimpaired.nvim', --mainly uses [ and ], ie ]e swaps line 1 down
        config = function() require('unimpaired').setup() end
    }

    use {
        'ethanholz/nvim-lastplace', --remember last place cursor was at
        config = function() require('nvim-lastplace').setup() end
    }

    use {
        'max397574/better-escape.nvim', --less laggy insert escape using jj or jk
        config = function() require('better_escape').setup() end
    }

    --Directory
    use 'ahmedkhalf/project.nvim' --auto set working directory to root of current file


    use 'nvim-tree/nvim-tree.lua' --show file directory on left

end)
