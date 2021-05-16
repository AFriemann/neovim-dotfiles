local indent = 2

-- the gs
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'

-- global options
local o = vim.o

-- search
o.smartcase = true
o.hlsearch = true
o.incsearch = true
-- scroll context
o.scrolloff = 4             -- Lines of context
o.sidescrolloff = 8         -- Columns of context
-- colors
o.termguicolors = true      -- True color support
-- behaviour
o.wildmode = 'list:longest' -- Command-line completion mode
o.hidden = true
-- indentation
o.expandtab = true
o.tabstop = indent
o.shiftwidth = indent
o.smartindent = false

-- window-local options
local wo = vim.wo

wo.number = true
wo.relativenumber = true

-- buffer-local options
local bo = vim.bo

-- local fn = vim.fn
-- local g = vim.g
-- local o = vim.o
-- local wo = vim.wo
-- local bo = vim.bo
-- 
-- vim.cmd 'packadd paq-nvim'         -- Load package
-- local paq = require 'paq-nvim' . paq  -- Import module and bind `paq` function
-- paq { 'savq/paq-nvim', opt=true }  -- Let Paq manage itself
-- 
-- -- add packages
-- 
-- paq 'neovim/nvim-lspconfig'
-- 
-- local indent = 2
-- 
-- o.number  = true
-- wo.number = true
