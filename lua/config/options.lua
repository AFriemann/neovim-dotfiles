-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.python_host_prog = "/usr/bin/python"

vim.opt.title = true

vim.lsp.log.set_level("off")

vim.opt.colorcolumn = "120"

-- Native inline completions don't support being shown as regular completions
-- vim.g.ai_cmp = false

local space = "·"
vim.opt.listchars:append({
  -- eol = "$",
  tab = "·→",
  -- multispace = space,
  -- lead = space,
  trail = space,
  nbsp = space,
  extends = "▶",
  precedes = "◀",
})

vim.opt.list = true
