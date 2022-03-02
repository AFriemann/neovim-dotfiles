local set_keymap = vim.api.nvim_set_keymap

set_keymap('n', 'n', 'nzz', { noremap = true, silent = false })
set_keymap('n', 'N', 'Nzz', { noremap = true, silent = false })


set_keymap("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", {silent = true, noremap = true})
set_keymap("n", "<leader>r", "<cmd>NvimTreeRefresh<cr>", {silent = true, noremap = true})
set_keymap("n", "<leader>n", "<cmd>NvimTreeFindFile<cr>", {silent = true, noremap = true})

set_keymap("n", "<leader>t", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
set_keymap("n", "<leader>ca", "<cmd>CodeActionMenu<cr>", {silent = true, noremap = true})

set_keymap('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
set_keymap('n', '<S-Tab>', '<cmd>BufferLineCyclePrevious<CR>', { noremap = true, silent = true })
