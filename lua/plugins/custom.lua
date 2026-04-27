return {
  {
    "folke/neoconf.nvim",
    opts = {},
  },
  {
    "tris203/precognition.nvim",
    dependencies = { "chrisgrieser/nvim-spider" },
    opts = {
      showBlankVirtLine = false,
      gutterHints = {
        G = { text = "G", prio = 10 },
        gg = { text = "gg", prio = 9 },
        PrevParagraph = { text = "{", prio = 8 },
        NextParagraph = { text = "}", prio = 8 },
      },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    opts = {}, -- calls `setup()`, which registers the precognition adapter
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
      { "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- high priority required, luarocks.nvim should run as the first plugin in your config
    lazy = false,
    opts = {
      rocks = { "luautf8" }, -- specifies a list of rocks to install
    },
  },
  {
    "wsdjeg/rooter.nvim",
    config = function()
      require("rooter").setup({})
    end,
  },
  { "taybart/b64.nvim" },
  { "nicwest/vim-camelsnek" },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {},
  },
}
