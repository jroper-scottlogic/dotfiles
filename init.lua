--[[
config file for neovim, written in lua
usually included in the config - in order to find where execute :echo stdpath('config')
in order to call this one, create an init.lua file there and include
source ~/dotfiles/init.lua
source ~/dotfiles/plugins.lua
--]]

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'CursorHoldI', 'FocusGained' }, {
    command = 'if mode() != \'c\' | checktime | endif',
    pattern = { '*' },
})

local options = {
    inccommand = 'nosplit', -- Show effect of command incrementally while writing it (substitution)
    mouse = 'a',         -- Enable mouse in all mode
    tabstop = 4,         -- A tab is 4 spaces (display)
    shiftwidth = 4,      -- Indent to 4 spaces
    softtabstop = 4,     -- A tab is 4 spaces (insert mode)
    expandtab = true,    -- Use spaces instead of tab character
    smartindent = true,  -- Smart auto indent on new line
    cursorline = true,   -- Highlight the current line the cursor is on
    hidden = true,       -- Make sure hidden buffer are not unloaded
    backup = true,       -- Ensable file backups
    writebackup = true,  -- Disable file backup on save
    swapfile = false,    -- Disable swap files
    number = true,       -- Show line numbers
    scrolloff = 8,       -- Keep at least 8 lines above the cursor.
    wrap = false,        -- Disable line wrap
    colorcolumn = '100', -- Color the 120 character as a limit for line length
}

for opt, val in pairs(options) do
    vim.opt[opt] = val
end

local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
ts_update()

vim.o.background = 'dark' -- or 'light' for light mode
vim.cmd([[colorscheme gruvbox-material]])

require('hlargs').setup {
    use_colorpalette = true,
}
require 'ts-rainbow'

require('nvim-treesitter.configs').setup {
    rainbow = {
        enable = true,
        query = {
            'rainbow-parens',
            html = 'rainbow-tags',
        },
        hlgroups = { --taken from gruvbox material values
            'purple',
            'yellow',
            'red',
            'blue',
            'orange',
            'green'
        },
    }
}
require 'plenary.async' --installs all other plenary modules

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
    require('nvim-tree.api').tree.open()
end
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })

require('bufferline').setup {
    options = {
        numbers = 'buffer_id',
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Explorer',
                text_align = 'center',
                separator = true
            }
        },
    }
}

require('mason').setup()
local mlsp = require('mason-lspconfig')
mlsp.setup {
    ensure_installed = { 'lua_ls' }
}
local lsp = require('lsp-zero').preset({
    name = 'recommended',
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.diagnostic.config({ virtual_text = true, })

local null_ls = require('null-ls')

null_ls.setup({
    sources = {
    },
})
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.formatting_sync()
        end,
    })
  end
end
null_ls.setup {
    debug = true,
    sources = true,
    on_attach = on_attach,
}
