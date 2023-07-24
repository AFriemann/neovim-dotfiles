VIM = vim

local opt = VIM.opt

-- magic numbers
local indent = 2

-- the gs
VIM.g.loaded_python_provider = 0
VIM.g.python3_host_prog = '/usr/bin/python3'
VIM.g.python_host_prog = '/usr/bin/python'

-- completion
--opt.shortmess = VIM.o.shortmess .. "c"        -- don't show completion messages
--opt.completeopt = 'menuone,noselect,noinsert' -- completion options
-- visual
opt.termguicolors = true -- enable 24-bit RGB colors
opt.listchars = 'tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:○,eol:↵'
opt.list = true
opt.number = true
opt.relativenumber = true
opt.syntax = 'off'
opt.showmatch = true
opt.colorcolumn = '120'
opt.cursorline = true
opt.signcolumn = 'yes'
-- search
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
-- scroll context
opt.scrolloff = 4
opt.sidescrolloff = 8
-- behaviour
opt.wildmode = 'list:longest'
opt.hidden = true             -- enable background buffers
opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
opt.mouse = "a"               -- enable mouse support
opt.history = 100             -- remember n lines in history
opt.lazyredraw = true         -- faster scrolling
opt.synmaxcol = 2048          -- max column for syntax highlighting
opt.breakindent = true        -- enable break indent
opt.undofile = true           -- save undo history
opt.updatetime = 250          -- decrease update time
-- indentation
opt.expandtab = true          -- use spaces instead of tabs
opt.tabstop = indent          -- 1 tab == `indent` spaces
opt.shiftwidth = indent       -- shift `indent` spaces when tab
opt.smartindent = false       -- results in faulty indentation
opt.autoindent = true
-- folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

VIM.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

-- Highlight on yank
VIM.api.nvim_create_autocmd('TextYankPost', {
  pattern = "*",
  command = 'silent! lua VIM.highlight.on_yank{higroup="IncSearch", timeout=700}',
  group = VIM.api.nvim_create_augroup('YankHighlight', { clear = true }),
})

-- show cursor line only in active window
local cursorGrp = VIM.api.nvim_create_augroup("CursorLine", { clear = true })
VIM.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp
})
VIM.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  command = "set nocursorline",
  group = cursorGrp
})

-- windows to close with "q"
VIM.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "startuptime", "qf", "lspinfo" },
  command = [[nnoremap <buffer><silent> q :close<CR>]]
})
VIM.api.nvim_create_autocmd("FileType", {
  pattern = "man",
  command = [[nnoremap <buffer><silent> q :quit<CR>]]
})
