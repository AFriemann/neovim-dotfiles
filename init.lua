require 'plugins'
require 'keybindings'
require 'options'
require 'filetypes'

local cmd = vim.api.nvim_command

function autosync()
  require('nvim-reload').Reload()
  cmd('PackerInstall')
  cmd('PackerCompile')
end

function autoreload()
  require('nvim-reload').Reload()
end

cmd('augroup AutoSync')
cmd('autocmd BufWritePost plugins.lua lua autosync()')
cmd('augroup END')

cmd('augroup AutoReload')
cmd('autocmd BufWritePost init.lua lua autoreload()')
cmd('augroup END')

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_transparent = true
cmd('colorscheme tokyonight')
