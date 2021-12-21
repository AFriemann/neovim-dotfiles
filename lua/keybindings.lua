local set_keymap = vim.api.nvim_set_keymap

set_keymap('n', 'n', 'nzz', { noremap = true, silent = false })
set_keymap('n', 'N', 'Nzz', { noremap = true, silent = false })

set_keymap("n", "<leader>ct", "<cmd>Trouble<cr>", {silent = true, noremap = true})
set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>', { noremap = true, silent = false })
set_keymap('n', '<leader>cd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = false })
set_keymap('n', '<leader>cc', '<cmd>Telescope git_bcommits<CR>', { noremap = true, silent = false })

set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = false })
set_keymap('n', '<leader>fp', '<cmd>Telescope projects<CR>', { noremap = true, silent = false })

-- set_keymap('n', '<leader>fg', '<cmd>Telescope git_files<CR>', { noremap = true, silent = false })
set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = false })
set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = false })
set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = false })
set_keymap('n', '<leader>fs', '<cmd>Telescope symbols<CR>', { noremap = true, silent = false })
set_keymap('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = false })
set_keymap('n', '<leader>fk', '<cmd>Telescope keymaps<CR>', { noremap = true, silent = false })

set_keymap('n', '<Tab>', '<cmd>tabnext<CR>', { noremap = true, silent = true })
set_keymap('n', '<S-Tab>', '<cmd>tabprevious<CR>', { noremap = true, silent = true })
