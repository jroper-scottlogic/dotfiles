--file for aaaall the plugins to include for neovim, using vim-plug plugin manager
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

--ui 
Plug 'ellisonleao/gruvbox.nvim' --lovely theme

Plug 'nvim-lualine/lualine.nvim' --lua airline equivalent
Plug 'kyazdani42/nvim-web-devicons' --use nerd fonts. requires terminal to use one

Plug 'nvim-treesitter/nvim-treesitter' --syntax highlighting, used for others
Plug 'm-demare/hlargs.nvim' --highlight arguments of functions
Plug 'HiPhish/nvim-ts-rainbow2' --rainbow highlighting for parentheses
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'lukas-reineke/indent-blankline.nvim' --indent guidelines

Plug 'NvChad/nvim-colorizer.lua' --show colours as they're written

--utility
Plug 'ethanholz/nvim-lastplace' --remember last opened position
Plug 'tummetott/unimpaired.nvim' --lua port of tpope, useful keymaps
Plug 'kylechui/nvim-surround' --another tpope
Plug 'windwp/nvim-ts-autotag' --autoclose and autorename tags in html/js etc
Plug 'Pocco81/auto-save.nvim' --auto saves files

--git
Plug 'dinhhuy258/git.nvim' --git fugitive written in lua
Plug 'lewis6991/gitsigns.nvim' --show git info of file in left gutter

--directory
Plug 'ahmedkhalf/project.nvim' --auto set working directory
Plug 'nvim-tree/nvim-tree.lua' --nerd tree alternative

--LSP
Plug 'nvim-lua/plenary.nvim' --needed for la functions 
Plug 'williamboman/mason.nvim' --package manager for lsp servers, linters etc
Plug 'williamboman/mason-lspconfig.nvim' --bridge the gap
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'MunifTanjim/prettier.nvim'

Plug 'lewis6991/hover.nvim' --get lsp info when hovering

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

--For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

--has to go at the end
Plug 'ryanoasis/vim-devicons'
vim.call('plug#end')

--ui setup
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require('lualine').setup()
options = { theme = 'gruvbox',
icons_enabled = true}

require('hlargs').setup()

require("nvim-treesitter.configs").setup {
    rainbow = {
        enable = true,
        -- Which query to use for finding delimiters
        query = 'rainbow-parens',
        -- Highlight the entire buffer all at once
        strategy = require 'ts-rainbow.strategy.global',
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    },
    autotag = {
        enable = true,
    },
}

require('indent_blankline').setup()

require 'colorizer'.setup()

--utility setup
require('nvim-lastplace').setup()

require('unimpaired').setup()

require('nvim-surround').setup()

require('auto-save').setup()

--git setup
require('git').setup()

require('gitsigns').setup()


--directory setup
require('project_nvim').setup()

require('nvim-tree').setup {
    disable_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true
    },
}
local function open_nvim_tree()

    -- open the tree
    require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

--LSP
local async = require "plenary.async" --loads all other plenary modules too

require("mason").setup()
require("mason-lspconfig").setup()

local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            -- format on save
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
                buffer = bufnr,
                group = group,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, async = async })
                end,
                desc = "[lsp] format on save",
            })
        end

        if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("x", "<Leader>f", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
        end
    end,
})

local prettier = require("prettier")

prettier.setup({
    bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
    cli_options = {
        arrow_parens = "always",
        bracket_spacing = true,
        bracket_same_line = false,
        embedded_language_formatting = "auto",
        --end_of_line = "lf",
        html_whitespace_sensitivity = "css",
        -- jsx_bracket_same_line = false,
        jsx_single_quote = true,
        print_width = 80,
        prose_wrap = "preserve",
        quote_props = "as-needed",
        semi = true,
        single_attribute_per_line = false,
        single_quote = false,
        --tab_width = 1,
        trailing_comma = "es5",
        use_tabs = true,
        vue_indent_script_and_style = false,
    },
})

require("hover").setup {
    init = function()
        -- Require providers
        require("hover.providers.lsp")
        -- require('hover.providers.gh')
        -- require('hover.providers.gh_user')
        -- require('hover.providers.jira')
        -- require('hover.providers.man')
        -- require('hover.providers.dictionary')
    end,
    preview_opts = {
        border = nil
    },
    -- Whether the contents of a currently open hover window should be moved
    -- to a :h preview-window when pressing the hover keymap.
    preview_window = false,
    title = true
}


local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
