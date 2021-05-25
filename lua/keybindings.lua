local set_keymap = vim.api.nvim_set_keymap

set_keymap('n', '<Tab>', ':tabnext<CR>', { noremap = true, silent = true })
set_keymap('n', '<S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })

--  vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Trouble<cr>",
--    {silent = true, noremap = true}
--  )
