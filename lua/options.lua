local api = vim.api

local set_global = api.nvim_set_option
local set_window = api.nvim_win_set_option
local set_buffer = api.nvim_buf_set_option

-- magic numbers
local indent = 2

-- the gs
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'

-- visual
set_global('termguicolors', true)
-- search
set_global('smartcase', true)
set_global('hlsearch', true)
set_global('incsearch', true)
-- scroll context
set_global('scrolloff', 4)             -- Lines of context
set_global('sidescrolloff', 8)         -- Columns of context
-- colors
set_global('termguicolors', true)      -- True color support
-- behaviour
set_global('wildmode', 'list:longest') -- Command-line completion mode
set_global('hidden', true)
-- indentation
set_buffer(0, 'expandtab', true)
set_buffer(0, 'tabstop', indent)
set_buffer(0, 'shiftwidth', indent)
set_global('smartindent', true)
set_global('listchars', 'tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:○,eol:↵')

set_window(0, 'list', true)
set_window(0, 'number', true)
set_window(0, 'relativenumber', true)
