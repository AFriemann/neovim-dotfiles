local set_keymap = vim.api.nvim_set_keymap

set_keymap('n', '<Tab>', ':tabnext<CR>', { noremap = true, silent = true })
set_keymap('n', '<S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })

set_keymap('n', 'n', 'nzz', { noremap = true, silent = false })
set_keymap('n', 'N', 'Nzz', { noremap = true, silent = false })

vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)

local snap = require('snap')

snap.register.map({"n"}, {"<C-p>"}, function()
  snap.run {
    prompt = 'Files',
    producer = snap.get('consumer.fzy')(snap.get('producer.ripgrep.file')),
    select = snap.get('select.file').select,
    multiselect = snap.get('select.file').multiselect,
  } 
end)

snap.register.map({"n"}, {"<leader>f"}, function()
  snap.run {
    prompt = 'Git Files',
    producer = snap.get('consumer.fzy')(snap.get('producer.git.file')),
    select = snap.get('select.file').select,
    multiselect = snap.get('select.file').multiselect,
  } 
end)

snap.register.map({"n"}, {"<leader>g"}, function()
  snap.run {
    prompt = 'Grep',
    producer = snap.get('consumer.limit')(10000, snap.get('producer.ripgrep.vimgrep')),
    select = snap.get('select.vimgrep').select,
    multiselect = snap.get('select.vimgrep').multiselect,
    views = { snap.get('preview.vimgrep') }
  } 
end)
