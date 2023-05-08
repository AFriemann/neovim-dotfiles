VIM = vim

VIM.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = 'Jenkinsfile',
  command = 'setf groovy.jenkinsfile',
  group   = VIM.api.nvim_create_augroup("Jenkins", { clear = true }),
})
