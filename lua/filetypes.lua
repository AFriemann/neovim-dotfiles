local cmd = vim.api.nvim_command

cmd('augroup i3config_ft')
cmd('au FileType i3config ColorizerToggle')
cmd('augroup END')
