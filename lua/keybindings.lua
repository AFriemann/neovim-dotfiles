VIM = vim

local set_keymap = VIM.api.nvim_set_keymap

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

VIM.api.nvim_create_autocmd('TermEnter', {
  pattern = 'term://*toggleterm#*',
  command = 'tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>'
})

set_keymap('n', '<C-t>', '<cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
set_keymap('i', '<C-t>', '<esc><cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })

VIM.g.diagnostics_visible = true
function _G.toggle_diagnostics()
  if VIM.g.diagnostics_visible then
    VIM.g.diagnostics_visible = false
    VIM.diagnostic.disable()
  else
    VIM.g.diagnostics_visible = true
    VIM.diagnostic.enable()
  end
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
VIM.api.nvim_create_autocmd('LspAttach', {
  group = VIM.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    VIM.keymap.set('n', '<leader>f', function()
      VIM.lsp.buf.format { async = true }
    end, opts)
  end,
})
