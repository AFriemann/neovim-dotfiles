local api = vim.api
local opt = vim.opt

-- magic numbers
local indent = 2

-- the gs
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'

-- completion
opt.shortmess = vim.o.shortmess .. "c"
opt.completeopt = 'menuone,noinsert,noselect'
-- visual
opt.termguicolors = true
opt.listchars = 'tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:○,eol:↵'
opt.list = true
opt.number = true
opt.relativenumber = true
opt.syntax = 'off'
opt.signcolumn = "number"
-- search
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
-- scroll context
opt.scrolloff = 4
opt.sidescrolloff = 8
-- behaviour
opt.wildmode = 'list:longest'
opt.hidden = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"
-- indentation
opt.expandtab = true
opt.tabstop = indent
opt.shiftwidth = indent
opt.smartindent = true
opt.autoindent = true
