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
  use { 'vim-scripts/LargeFile' } -- TODO: not sure this actually works
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
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require'nvim-tree'.setup {
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
      'yioneko/nvim-yati',
    },
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {'bash', 'lua', 'hcl', 'go', 'python', 'rust'},
        highlight = { enable = true, },
        indent = { enable = true, },
        yati = { enable = true },
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
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind-nvim',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')
      local types = require('cmp.types')
      local lspkind = require('lspkind')

      cmp.setup {
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'luasnip' },
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        completion = {
          autocomplete = {
            types.cmp.TriggerEvent.InsertEnter,
            types.cmp.TriggerEvent.TextChanged,
          },
          completeopt = 'menu,menuone,noselect',
          keyword_length = 1,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          -- ['<CR>'] = cmp.mapping.confirm({
          --   behavior = cmp.ConfirmBehavior.Replace,
          --   select = true,
          -- }),
        },
        formatting = {
          format = function(_, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            return vim_item
          end
        }
      }

      vim.api.nvim_exec([[
        augroup completion
          autocmd!
          autocmd FileType lua lua require('cmp').setup.buffer { sources = { name = 'nvim_lua' }, }
        augroup end
      ]], false)
    end
  }

  use {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'folke/lsp-colors.nvim',
      'onsails/lspkind-nvim',
      'tjdevries/nlua.nvim',
      'lukas-reineke/lsp-format.nvim'
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
        mode = "symbol_text",
        preset = 'default',
      }

      local on_attach = function(client, bufnr)
        require "lsp-format".on_attach(client)

        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local opts = { noremap=true, silent=true }

        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

        if client.resolved_capabilities.document_formatting then
          buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        end

        if client.resolved_capabilities.document_range_formatting then
          buf_set_keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        end
      end

      local servers = { "pylsp", "bashls", "jsonls", "groovyls", "dockerls", "yamlls", "gopls", "rls", "tflint" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup { on_attach = on_attach }
      end

      lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        cmd = {"lua-language-server"},
      }

      lspconfig.terraformls.setup {
        on_attach = on_attach,
        filetypes = {'terraform', 'tf', 'hcl',},
      }

      lspconfig.groovyls.setup {
        cmd = { "java", "-jar", "/usr/libexec/groovy-language-server/groovy-language-server.jar" },
      }
    end
  }

  use {
    'RishabhRD/nvim-lsputils',
    requires = {
      'RishabhRD/popfix',
    },
    config = function()
      vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
      vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
      vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
      vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
      vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
      vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
      vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
      vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
    end
  }

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

  use {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_highlight_group = "Question"
    end
  }

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
