require 'plugins'
require 'keybindings'
require 'options'
require 'filetypes'

local cmd = vim.api.nvim_command

function Autosync()
  require('nvim-reload').Reload()
  cmd('PackerInstall')
  cmd('PackerCompile')
end

function Autoreload()
  require('nvim-reload').Reload()
end

--cmd('augroup AutoSync')
--cmd('autocmd BufWritePost ~/.config/nvim/lua/plugins.lua lua autosync()')
--cmd('augroup END')

-- cmd('augroup AutoReload')
-- cmd('autocmd BufWritePost ~/.config/nvim/init.lua lua autoreload()')
-- cmd('autocmd BufWritePost ~/.config/nvim/lua/*.lua lua autoreload()')
-- cmd('augroup END')

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = true
--vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_lualine_bold = true
vim.g.tokyonight_sidebars = { "packer" }

vim.cmd[[colorscheme tokyonight]]
