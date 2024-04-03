-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- -- disable yamlls in helm templates
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("helm"),
--   pattern = { "helm" },
--   callback = function()
--     vim.cmd("LspStop yamlls")
--   end,
-- })
