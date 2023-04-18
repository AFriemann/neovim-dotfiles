local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  --vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup({
  function(use)
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

    use {
      'mfussenegger/nvim-ansible',
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
    use {
      'FooSoft/vim-argwrap',
      config = function()
        vim.keymap.set("n", "<leader>a", '<CMD>ArgWrap<CR>')
      end
    }
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

    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
      }
    }

    use({
      'gnikdroy/projections.nvim',
      requires = {
        'nvim-telescope/telescope.nvim',
      },
      config = function()
        require("projections").setup({
          workspaces = {
            "~/git",
            "~/work/clark/repositories",
          },
          patterns = { ".git" },
        })

        -- Bind <leader>fp to Telescope projections
        require('telescope').load_extension('projections')
        vim.keymap.set("n", "<leader>fp", function() vim.cmd("Telescope projections") end)

        -- Autostore session on DirChange and VimExit
        local Session = require("projections.session")
        vim.api.nvim_create_autocmd({ 'DirChangedPre', 'VimLeavePre' }, {
          callback = function() Session.store(vim.loop.cwd()) end,
        })
      end
    })

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
          disable_netrw = true,
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
                { key = "<C-v>",                          action = "vsplit" },
                { key = "<C-x>",                          action = "split" },
                { key = "<C-t>",                          action = "tabnew" },
                { key = "<",                              action = "prev_sibling" },
                { key = ">",                              action = "next_sibling" },
                { key = "P",                              action = "parent_node" },
                { key = "<BS>",                           action = "close_node" },
                --{ key = "<Tab>",                        action = "preview" },
                { key = "K",                              action = "first_sibling" },
                { key = "J",                              action = "last_sibling" },
                { key = "I",                              action = "toggle_ignored" },
                { key = "H",                              action = "toggle_dotfiles" },
                { key = "R",                              action = "refresh" },
                { key = "a",                              action = "create" },
                { key = "<C-d>",                          action = "remove" },
                { key = "D",                              action = "trash" },
                { key = "r",                              action = "rename" },
                { key = "<C-r>",                          action = "full_rename" },
                { key = "<C-x>",                          action = "cut" },
                { key = "c",                              action = "copy" },
                { key = "p",                              action = "paste" },
                { key = "y",                              action = "copy_name" },
                { key = "Y",                              action = "copy_path" },
                { key = "gy",                             action = "copy_absolute_path" },
                { key = "[c",                             action = "prev_git_item" },
                { key = "]c",                             action = "next_git_item" },
                { key = "-",                              action = "dir_up" },
                { key = "s",                              action = "system_open" },
                { key = "q",                              action = "close" },
                { key = "g?",                             action = "toggle_help" },
                { key = "W",                              action = "collapse_all" },
                { key = "S",                              action = "search_node" }
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
          ensure_installed = { 'bash', 'lua', 'hcl', 'go', 'python', 'rust', 'json', 'terraform', },
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

    -- -- TODO: not sure yet
    -- use {
    --   'phaazon/notisys.nvim',
    --   config = function()
    --     require 'notisys'.setup()
    --   end
    -- }

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
          sections = {
            lualine_a = {
              json_section
            },
            lualine_c = {
              {
                'filename',
                path = 1,
              },
            },
          },
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
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'petertriho/cmp-git' },
        { 'Dosx001/cmp-commit' },
        { 'davidsierradz/cmp-conventionalcommits' },
        { 'ray-x/cmp-treesitter' },
        { 'onsails/lspkind.nvim' },
      },
      config = function()
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          formatting  = {
            format = require('lspkind').cmp_format()
          },
          sources = cmp.config.sources({
    --         { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'treesitter' },
            { name = 'buffer' },
            { name = 'path' },
          })
        })

        require("cmp_git").setup()

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'conventionalcommits' },
            { name = 'cmp_git' },
            { name = 'buffer' },
          })
        })

        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })
      end
    }

    use {
      'williamboman/mason.nvim',
      requires = {
        { 'williamboman/mason-lspconfig.nvim' },
        { 'neovim/nvim-lspconfig' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'j-hui/fidget.nvim' },
        { 'RRethy/vim-illuminate' },
        { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
        { 'hrsh7th/nvim-cmp' },
        { 'onsails/lspkind.nvim' },
      },
      config = function()
        require('mason').setup()

        require('mason-lspconfig').setup({
          ensure_installed = {
            -- Replace these with whatever servers you want to install
            'rust_analyzer',
            'tsserver',
            'tflint',
            'terraformls',
            'ansiblels',
            'bashls',
            'groovyls',
            'ruff_lsp',
            'lua_ls',
            'cssls',
          }
        })

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lsp_attach = function(client, bufnr)
          -- Create your keybindings here...
        end

        local lspconfig = require('lspconfig')
        require('mason-lspconfig').setup_handlers({
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = lsp_attach,
              capabilities = lsp_capabilities,
            })
          end,
        })

        -- lspkind
        require('lspkind').init {
          mode = "symbol_text",
          preset = 'default',
        }

        -- fidget
        require('fidget').setup {
          window = {
            blend = 0,
          },
        }

        -- illuminate
        require('illuminate').configure({
          providers = {
            'lsp',
            'treesitter',
          }
        })

        -- lsp_lines
        require('lsp_lines').setup()

        vim.lsp.set_log_level("error")
      end
    }

    use {
      'weilbith/nvim-code-action-menu',
      cmd = 'CodeActionMenu',
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
  }
})
