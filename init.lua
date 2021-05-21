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
