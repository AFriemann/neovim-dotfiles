local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  --vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  -- CATEGORY colors
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'folke/tokyonight.nvim' }
  --use { 'rebelot/kanagawa.nvim' }

  -- CATEGORY performance
  use {
    'antoinemadec/FixCursorHold.nvim',
    run = function()
      vim.g.curshold_updatime = 100
    end,
  }

  -- CATEGORY utility

  -- sa[wrap] add
  -- sr[wrap] replace
  -- sd[wrap] delete
  use { 'machakann/vim-sandwich' }

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function ()
      require("bufferline").setup {}
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require'nvim-tree'.setup {
        auto_close = true,
        open_on_tab = true,
        hijack_unnamed_buffer_when_opening = true,
        diagnostics = {
          enable = true,
        },
        view = {
          mappings = {
            custom_only = true,
            list = {
              { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
              --{ key = "<C-e>",                        action = "edit_in_place" },
              --{ key = {"O"},                          action = "edit_no_picker" },
              --{ key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
              { key = "<C-v>",                        action = "vsplit" },
              { key = "<C-x>",                        action = "split" },
              { key = "<C-t>",                        action = "tabnew" },
              { key = "<",                            action = "prev_sibling" },
              { key = ">",                            action = "next_sibling" },
              { key = "P",                            action = "parent_node" },
              { key = "<BS>",                         action = "close_node" },
              --{ key = "<Tab>",                        action = "preview" },
              { key = "K",                            action = "first_sibling" },
              { key = "J",                            action = "last_sibling" },
              { key = "I",                            action = "toggle_ignored" },
              { key = "H",                            action = "toggle_dotfiles" },
              { key = "R",                            action = "refresh" },
              --{ key = "a",                            action = "create" },
              { key = "<C-d>",                        action = "remove" },
              { key = "D",                            action = "trash" },
              { key = "r",                            action = "rename" },
              { key = "<C-r>",                        action = "full_rename" },
              { key = "<C-x>",                        action = "cut" },
              { key = "c",                            action = "copy" },
              { key = "p",                            action = "paste" },
              { key = "y",                            action = "copy_name" },
              { key = "Y",                            action = "copy_path" },
              { key = "gy",                           action = "copy_absolute_path" },
              { key = "[c",                           action = "prev_git_item" },
              { key = "]c",                           action = "next_git_item" },
              { key = "-",                            action = "dir_up" },
              { key = "s",                            action = "system_open" },
              { key = "q",                            action = "close" },
              { key = "g?",                           action = "toggle_help" },
              { key = "W",                            action = "collapse_all" },
              { key = "S",                            action = "search_node" }
            }
          }
        }
      }
    end
  }

  use {
    'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup {}
    end
  }

  use { 'markonm/traces.vim' }
  use {
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('hlargs').setup()
    end
  }

  use {
    'mboughaba/i3config.vim',
    ft = {'i3config'}
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require("indent_blankline").setup {
        char = '┊',
        use_treesitter = true,
        show_first_indent_level = false,
        show_current_context = true,
        show_current_context_start = false,
        show_end_of_line = true,
        context_highlight_list = {'Question'},
        context_patterns = {'class', 'function', 'method', 'if_statement'},
        filetype_exclude = {'help'},
      }
    end
  }

  -- use { "tversteeg/registers.nvim" } -- TODO: this turns off syntax highlighting on reload
  -- use { 'ggandor/lightspeed.nvim' }  -- TODO: conflicts with vim-sandwich

  -- TODO: not sure if i'd use it yet
  -- use {
  --   'hoschi/yode-nvim',
  --   requires = {
  --     'nvim-lua/plenary.nvim'
  --   },
  --   config = function()
  --     require('yode-nvim').setup({})
  --   end
  -- }

  -- CATEGORY magic

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      'andymass/vim-matchup',
      --'yioneko/nvim-yati', -- TODO: this causes wrong indentation currently
    },
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {'bash', 'lua', 'hcl', 'go', 'python', 'rust'},
        highlight = { enable = true, },
        indent = { enable = true, },
        --yati = { enable = true },
        incremental_selection = { enable = true, },
        matchup = {
          enable = true,
        },
      }
      -- autofold ts objects:
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  }

  use({
    'mvllow/modes.nvim',
    event = 'BufRead',
    config = function()
      vim.opt.cursorline = true
      require('modes').setup()
    end
  })

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use {
    'hoob3rt/lualine.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
      {'folke/tokyonight.nvim'},
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
        }
      }
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
    -- Red
    -- Green
    -- Blue
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/nvim-lsp-installer'},
      {'onsails/lspkind-nvim'},
      {'folke/lsp-colors.nvim'},

      -- Formatting
      {'lukas-reineke/lsp-format.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    },
    config = function()
      local lsp = require('lsp-zero')
      local lspkind = require('lspkind')
      local lspformat = require("lsp-format")

      lsp.preset('recommended')
      lsp.nvim_workspace()

      lsp.ensure_installed({
        "pyright", "bashls", "jsonls", "groovyls", "dockerls", "yamlls", "gopls", "rls", "tflint"
      })

      lsp.on_attach(function(client)
        lspformat.on_attach(client)
      end)

      lspkind.init {
        mode = "symbol_text",
        preset = 'default',
      }

      lsp.setup_nvim_cmp({
        formatting = {
          format = lspkind.cmp_format(),
        },
        documentation = {
          border = { '', '', '', ' ', '', '', '', ' ' }, -- remove the obnoxious borders
        }
      })

      lsp.setup()

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
      })
    end
  }

  use {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  }

  use {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  -- use {
  --   'RishabhRD/nvim-lsputils',
  --   requires = {
  --     'RishabhRD/popfix',
  --   },
  --   config = function()
  --     vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
  --     vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
  --     vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
  --     vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
  --     vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
  --     vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
  --     vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
  --     vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
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
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  }

  -- CATEGORY git

  -- use {
  --   'rhysd/git-messenger.vim',
  --   config = function()
  --     vim.g.git_messenger_always_into_popup = true
  --   end
  -- }
  --
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup {
        sign_priority = 0,
      }
      vim.opt.signcolumn = "yes"
    end
  }

  -- use {
  --   'f-person/git-blame.nvim',
  --   config = function()
  --     vim.g.gitblame_highlight_group = "Question"
  --   end
  -- }

  -- use {
  --   'tanvirtin/vgit.nvim',
  --   requires = {
  --     'nvim-lua/plenary.nvim'
  --   },
  --   config = function()
  --     require('vgit').setup()
  --   end
  -- }

  if packer_bootstrap then
    require('packer').sync()
  end
end,
config = {
  profile = {
      enable = true,
      threshold = 1
  },
  display = {
    open_fn = require('packer.util').float,
  }
}})
