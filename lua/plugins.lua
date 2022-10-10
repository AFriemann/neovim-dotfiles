local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  --vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'

  -- CATEGORY colors
  use { 'kyazdani42/nvim-web-devicons' }
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

      require("catppuccin").setup({
        integrations = {
          fidget = true,
          gitsigns = true,
          cmp = true,
          treesitter = true,
          nvimtree = true,
          lsp_trouble = true,
          -- symbols_outline = true,
        },
      })

      vim.api.nvim_command "colorscheme catppuccin"
    end
  }

  -- fancy cursor colors
  use { 'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup({
        fancy = {
          enable = true,
        },
      })
    end
  }

  -- CATEGORY syntax highlighting
  use {
    'evanleck/vim-svelte',
    requires = {
      'othree/html5.vim',
      'pangloss/vim-javascript',
    }
  }

  -- CATEGORY performance
  use {
    'antoinemadec/FixCursorHold.nvim',
    run = function()
      vim.g.curshold_updatime = 100
    end,
  }

  use { 'gentoo/gentoo-syntax' }

  -- CATEGORY utility
  use { 'lewis6991/impatient.nvim' }
  use {
    'nicwest/vim-camelsnek'
    -- :Snek, :Camel, :CamelB, Kebab
  }
  use {
    -- gm to record macro, ESC to exit and M to apply to subsequent matches
    -- gM to change word, ESC to exit insert and M to change subsequent matches
    -- use g!M to only change full word matches
    -- use ga to apply all matches instead of M
    'otavioschwanck/cool-substitute.nvim',
    config = function()
      require('cool-substitute').setup({
        setup_keybindings = true,
      })
    end
  }

  use {
    'gaoDean/autolist.nvim',
    config = function()
      require('autolist').setup({
        enabled = true,
        create_enter_mapping = true,
      })
    end
  }

  use {
    "akinsho/toggleterm.nvim",
    branch = 'main',
    config = function()
      require("toggleterm").setup()
    end,
  }

  -- sa[wrap] add
  -- sr[wrap] replace
  -- sd[wrap] delete
  use { 'machakann/vim-sandwich' }

  use {
    'akinsho/bufferline.nvim',
    branch = 'main',
    requires = {
      'kyazdani42/nvim-web-devicons',
      'catppuccin'
    },
    config = function()
      require("bufferline").setup {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      }
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require 'nvim-tree'.setup {
        -- testing
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
        --
        open_on_tab = true,
        hijack_unnamed_buffer_when_opening = true,
        diagnostics = {
          enable = true,
        },
        view = {
          mappings = {
            custom_only = true,
            list = {
              { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
              --{ key = "<C-e>",                        action = "edit_in_place" },
              --{ key = {"O"},                          action = "edit_no_picker" },
              --{ key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
              { key = "<C-v>", action = "vsplit" },
              { key = "<C-x>", action = "split" },
              { key = "<C-t>", action = "tabnew" },
              { key = "<", action = "prev_sibling" },
              { key = ">", action = "next_sibling" },
              { key = "P", action = "parent_node" },
              { key = "<BS>", action = "close_node" },
              --{ key = "<Tab>",                        action = "preview" },
              { key = "K", action = "first_sibling" },
              { key = "J", action = "last_sibling" },
              { key = "I", action = "toggle_ignored" },
              { key = "H", action = "toggle_dotfiles" },
              { key = "R", action = "refresh" },
              { key = "a", action = "create" },
              { key = "<C-d>", action = "remove" },
              { key = "D", action = "trash" },
              { key = "r", action = "rename" },
              { key = "<C-r>", action = "full_rename" },
              { key = "<C-x>", action = "cut" },
              { key = "c", action = "copy" },
              { key = "p", action = "paste" },
              { key = "y", action = "copy_name" },
              { key = "Y", action = "copy_path" },
              { key = "gy", action = "copy_absolute_path" },
              { key = "[c", action = "prev_git_item" },
              { key = "]c", action = "next_git_item" },
              { key = "-", action = "dir_up" },
              { key = "s", action = "system_open" },
              { key = "q", action = "close" },
              { key = "g?", action = "toggle_help" },
              { key = "W", action = "collapse_all" },
              { key = "S", action = "search_node" }
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

  -- CATEGORY filetypes
  use {
    'mboughaba/i3config.vim',
    ft = { 'i3config' }
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
        context_highlight_list = { 'Question' },
        context_patterns = { 'class', 'function', 'method', 'if_statement' },
        filetype_exclude = { 'help' },
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
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { 'bash', 'lua', 'hcl', 'go', 'python', 'rust', 'json', },
        highlight_definitions = {
          enable = true,
          -- Set to false if you have an `updatetime` of ~100.
          clear_on_cursor_move = true,
        },
        highlight_current_scope = {
          enable = true,
        },
        highlight = {
          enable = true,
          use_languagetree = true,
        },
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

  -- use({
  --   'mvllow/modes.nvim',
  --   event = 'BufRead',
  --   config = function()
  --     vim.opt.cursorline = true
  --     require('modes').setup()
  --   end
  -- })

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- TODO: not sure yet
  use {
    'phaazon/notisys.nvim',
    config = function()
      require 'notisys'.setup()
    end
  }

  use {
    'hoob3rt/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
      { 'catppuccin' },
      { 'phelipetls/jsonpath.nvim' },
    },
    config = function()
      local jsonpath = require("jsonpath")

      local function json_section()
        if vim.bo.filetype == "json" then
          return jsonpath.get()
        else
          return [[]]
        end
      end

      require('lualine').setup {
        options = {
          theme = 'catppuccin',
        },
        sections = { lualine_a = { json_section } },
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
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'onsails/lspkind-nvim' },
      { 'folke/lsp-colors.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'nvim-lua/plenary.nvim' }, -- dependency for null-ls

      -- Utility
      { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
      { 'RRethy/vim-illuminate' },
      { 'j-hui/fidget.nvim' },
      -- { 'simrat39/symbols-outline.nvim' },

      -- Formatting
      { 'lukas-reineke/lsp-format.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'petertriho/cmp-git' },
      { 'Dosx001/cmp-commit' },
      { 'davidsierradz/cmp-conventionalcommits' },
      { 'ray-x/cmp-treesitter' },

      -- Snippets
      -- <C-d> next arg
      -- <C-b> previous arg
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' },

      -- Language specific
      { 'simrat39/rust-tools.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.preset('recommended')
      lsp_zero.nvim_workspace()

      local null_ls = require("null-ls")
      local lsp_lines = require('lsp_lines')

      lsp_zero.preset('recommended')
      lsp_zero.nvim_workspace()

      lsp_lines.setup()
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.jq,
        }
      })

      local lspformat = require("lsp-format")
      lsp_zero.on_attach(function(client)
        lspformat.on_attach(client)
      end)

      local lspkind = require('lspkind')
      lspkind.init {
        mode = "symbol_text",
        preset = 'default',
      }

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      lsp_zero.setup_nvim_cmp({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'treesitter' },
        },
        formatting = {
          format = lspkind.cmp_format(),
        },
        documentation = {
          border = { '', '', '', ' ', '', '', '', ' ' }, -- remove the obnoxious borders
        },
        mapping = lsp_zero.defaults.cmp_mappings({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'conventionalcommits' },
          { name = 'git' },
        })
      })

      require("cmp_git").setup()

      local rust_lsp = lsp_zero.build_options('rust_analyzer', {})

      lsp_zero.setup()

      -- rust-tools setup
      local rust_tools = require("rust-tools")

      rust_tools.setup({
        server = rust_lsp,
        tools = {
          inlay_hints = {
            auto = true,
            parameter_hints_prefix = " <- ",
            other_hints_prefix = " => ",
          },
        },
      })

      rust_tools.inlay_hints.enable()

      require("fidget").setup {
        window = {
          blend = 0,
        },
      }

      -- illuminate
      require("illuminate").configure({
        providers = {
          'lsp',
          'treesitter',
        }
      })

      -- require("symbols-outline").setup({
      --   auto_close = true,
      -- })
    end
  }

  use {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
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

  if PackerBootstrap then
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
  } })
