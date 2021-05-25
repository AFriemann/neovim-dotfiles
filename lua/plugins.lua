local fn = vim.fn
local execute = vim.api.nvim_command

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
    config = function()
      require('nvim-reload').post_reload_hook = function()
        require('feline').reset_highlights()
      end
    end
  }

  use {
    'antoinemadec/FixCursorHold.nvim',
    run = function()
      vim.g.curshold_updatime = 100
    end,
  }

  use {
    'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup {}
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {'lua'},
        highlight = { enable = true, },
        indent = { enable = true, },
        incremental_selection = { enable = true, },
        context_commentstring = {
          enable = true
        }
      }
    end,
    run = ':TSUpdate',
  }

--  use "tversteeg/registers.nvim" -- this turns off syntax highlighting on reload
  use 'markonm/traces.vim'

  use { 'folke/tokyonight.nvim', }

--  TODO saving file causes treesitter integration to fail
--  use {
--    'lukas-reineke/indent-blankline.nvim',
--    requires = 'nvim-treesitter/nvim-treesitter',
--    branch = 'lua',
--    config = function()
--      local g = vim.g
--
--      g.indent_blankline_char = '┊'
--      g.indent_blankline_use_treesitter = true
--      g.indent_blankline_show_first_indent_level = false
--      g.indent_blankline_show_current_context = true
--      g.indent_blankline_context_highlight_list = {'Warning'}
--      g.indent_blankline_context_patterns = {'class', 'function', 'method', 'if_statement'}
--      g.indent_blankline_filetype_exclude = {'help'}
--    end
--  }

  use {
    'tpope/vim-commentary'
  }

  use {
    'famiu/feline.nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require('feline').setup {}
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
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup {
        enable = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,
        source = {
          path = true,
          nvim_lsp = true,
        },
      }
    end
  }


  use {
    'neovim/nvim-lspconfig',
    requires = {
      'folke/lsp-colors.nvim',
      'onsails/lspkind-nvim',
    },
    config = function()
      local fn = vim.fn
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig/configs")

      fn.sign_define('LspDiagnosticsSignError', {text='', texthl='LspDiagnosticsSignError',linehl='', numhl=''})
      fn.sign_define('LspDiagnosticsSignWarning', {text='', texthl='LspDiagnosticsSignWarning', linehl='', numhl=''})
      fn.sign_define('LspDiagnosticsSignInformation', {text='', texthl='LspDiagnosticsSignInformation', linehl='', numhl=''})
      fn.sign_define('LspDiagnosticsSignHint', {text='💡', texthl='LspDiagnosticsSignHint', linehl='', numhl=''})

      require('lspkind').init {
        with_text = false,
        preset = 'default',
      }

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

      lspconfig.groovyls.setup {
        cmd = { "java", "-jar", "/usr/libexec/groovy-language-server/groovy-language-server.jar" },
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
    'rhysd/git-messenger.vim',
    config = function()
      vim.g.git_messenger_always_into_popup = true
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup {}
    end
  }

  use {
    'mboughaba/i3config.vim',
    ft = {'i3config'}
  }
end, {
  display = {
    open_fn = require('packer.util').float,
  }
})
