require 'plugins'
require 'keybindings'
require 'filetypes'
require 'options'

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = true
--vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_lualine_bold = true
vim.g.tokyonight_sidebars = { "packer" }

vim.cmd[[colorscheme tokyonight]]
