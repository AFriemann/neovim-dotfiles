local set_keymap = vim.api.nvim_set_keymap

set_keymap('n', 'n', 'nzz', { noremap = true, silent = false })
set_keymap('n', 'N', 'Nzz', { noremap = true, silent = false })

set_keymap("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { silent = true, noremap = true })
set_keymap("n", "<leader>r", "<cmd>NvimTreeRefresh<cr>", { silent = true, noremap = true })
set_keymap("n", "<leader>n", "<cmd>NvimTreeFindFile<cr>", { silent = true, noremap = true })

set_keymap("n", "<leader>t", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
set_keymap("n", "<leader>ca", "<cmd>CodeActionMenu<cr>", { silent = true, noremap = true })

set_keymap('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
set_keymap('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })

set_keymap('n', '<leader>l', ':call v:lua.toggle_diagnostics()<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd('TermEnter', {
  pattern = 'term://*toggleterm#*',
  command = 'tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>'
})

set_keymap('n', '<C-t>', '<cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
set_keymap('i', '<C-t>', '<esc><cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })

vim.g.diagnostics_visible = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_visible then
    vim.g.diagnostics_visible = false
    vim.diagnostic.disable()
  else
    vim.g.diagnostics_visible = true
    vim.diagnostic.enable()
  end
end
