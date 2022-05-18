local cmd = vim.api.nvim_command

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = 'Jenkinsfile',
  command = 'setf groovy',
  group   = vim.api.nvim_create_augroup("Jenkins", { clear = true }),
})
