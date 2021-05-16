local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'famiu/nvim-reload',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }

  use {
    'antoinemadec/FixCursorHold.nvim',
    run = function()
      vim.g.curshold_updatime = 100
    end,
  }

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

--  use "tversteeg/registers.nvim" -- this turns off syntax highlighting on reload
  use 'markonm/traces.vim'

  use 'shaunsingh/moonlight.nvim'
  require("moonlight").set()

  use {
    'lukas-reineke/indent-blankline.nvim'
  }

  use {
    'famiu/feline.nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require('feline').setup()
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {}
    end,
    -- Red
    run = ':ColorizerToggle',
  }

  use {
    'neovim/nvim-lspconfig',
    requires = 'folke/lsp-colors.nvim',
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig/configs")

      vim.fn.sign_define('LspDiagnosticsSignError', {text='', texthl='LspDiagnosticsSignError',linehl='', numhl=''})
      vim.fn.sign_define('LspDiagnosticsSignWarning', {text='', texthl='LspDiagnosticsSignWarning', linehl='', numhl=''})
      vim.fn.sign_define('LspDiagnosticsSignInformation', {text='', texthl='LspDiagnosticsSignInformation', linehl='', numhl=''})
      vim.fn.sign_define('LspDiagnosticsSignHint', {text='💡', texthl='LspDiagnosticsSignHint', linehl='', numhl=''})

      if not lspconfig.lualsp then
        configs.lualsp = {
          default_config = {
            cmd = {'/home/aljosha/.luarocks/bin/lua-lsp'};
            filetypes = {'lua'};
            root_dir = function(fname)
              return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
            end;
            settings = {};
          }
        }
      end

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

	if client.resolved_capabilities.document_formatting then
          buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        end

	if client.resolved_capabilities.document_range_formatting then
          buf_set_keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        end
      end

      local servers = { "pyls", "bashls", "jsonls", "groovyls", "dockerls", "lualsp", "yamlls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup { on_attach = on_attach }
      end

      lspconfig.terraformls.setup {
        on_attach = on_attach,
        filetypes = {'terraform', 'tf', 'hcl',},
      }
    end
  }

  -- TODO
  -- not working :(
  -- use {
  --   "folke/todo-comments.nvim",
  --   config = function()
  --     require("todo-comments").setup {}
  --   end
  -- }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  use {'rhysd/git-messenger.vim'}
end, {
  display = {
    open_fn = require('packer.util').float,
  }
})
