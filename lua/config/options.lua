-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.python_host_prog = "/usr/bin/python"

vim.opt.title = true

vim.lsp.set_log_level("off")
