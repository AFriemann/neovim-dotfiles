local cmd = vim.api.nvim_command

cmd('augroup jenkins')
cmd('au BufNewFile,BufRead Jenkinsfile setf groovy')
cmd('augroup END')
