local fn = vim.fn
local execute = vim.api.nvim_command

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'famiu/nvim-reload',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('nvim-reload').post_reload_hook = function()
        -- require('feline').reset_highlights()
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
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end
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
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      'andymass/vim-matchup',
    },
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {'lua', 'hcl', 'go', 'python', 'rust'},
        highlight = { enable = true, },
        indent = { enable = true, },
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
  --   config = function()
  --     require('modes').setup()
  --   end
  -- })

  use { 
    'JoosepAlviste/nvim-ts-context-commentstring',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require'nvim-treesitter.configs'.setup {
        context_commentstring = {
          enable = true
        }
      }
    end
  }

  use { 'machakann/vim-sandwich' }
    -- sa[wrap] add
    -- sr[wrap] replace
    -- sd[wrap] delete
  use { 'ggandor/lightspeed.nvim' }
  use { 'markonm/traces.vim' }
  use { 'folke/tokyonight.nvim' }
  use { 'tpope/vim-commentary' }

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
      require('colorizer').setup {}
    end,
    -- Red
    run = ':ColorizerToggle',
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

      -- handle <CR> mapping with nvim-cmp
      -- require("nvim-autopairs.completion.cmp").setup {
      --   map_cr = true, --  map <CR> on insert mode
      --   map_complete = true -- insert `(` when function/method is completed
      -- }
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'folke/lsp-colors.nvim',
      'onsails/lspkind-nvim',
      'tjdevries/nlua.nvim',
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

      local on_attach = function(client, bufnr)
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
      require('gitsigns').setup {
        sign_priority = 0,
      }
      vim.opt.signcolumn = "yes"
    end
  }

  use {
    'mboughaba/i3config.vim',
    ft = {'i3config'}
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-symbols.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close
            },
          },
        },
      }
      require('telescope').load_extension('fzy_native')
      require('telescope').load_extension('projects')
    end
  }

-- TODO: this turns off syntax highlighting on reload
--  use { "tversteeg/registers.nvim" }

--  TODO: saving file causes treesitter integration to fail
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

end, {
  display = {
    open_fn = require('packer.util').float,
  }
})
