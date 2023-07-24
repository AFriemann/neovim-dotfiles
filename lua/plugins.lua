VIM = vim

OPT = VIM.opt
FN = VIM.fn

local install_path = FN.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if FN.empty(FN.glob(install_path)) > 0 then
  PackerBootstrap = FN.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  --VIM.api.nvim_command 'packadd packer.nvim'
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
        VIM.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

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

        VIM.api.nvim_command "colorscheme catppuccin"
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
        VIM.g.curshold_updatime = 100
      end,
    }

    use { 'gentoo/gentoo-syntax' }

    -- CATEGORY utility
    use {
      'echasnovski/mini.align',
      config = function()
        require('mini.align').setup()
      end
    }

    use {
      'FooSoft/vim-argwrap',
      config = function()
        VIM.keymap.set("n", "<leader>a", '<CMD>ArgWrap<CR>')
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

    -- use {
    --   'nvim-telescope/telescope.nvim',
    --   requires = {
    --     'nvim-lua/plenary.nvim',
    --   }
    -- }

    -- use({
    --   'gnikdroy/projections.nvim',
    --   requires = {
    --     'nvim-telescope/telescope.nvim',
    --   },
    --   config = function()
    --     require("projections").setup({
    --       workspaces = {
    --         "~/git",
    --         "~/work/clark/repositories",
    --       },
    --       patterns = { ".git" },
    --     })
    --
    --     -- Bind <leader>fp to Telescope projections
    --     require('telescope').load_extension('projections')
    --     VIM.keymap.set("n", "<leader>fp", function() VIM.cmd("Telescope projections") end)
    --
    --     -- Autostore session on DirChange and VimExit
    --     local Session = require("projections.session")
    --     VIM.api.nvim_create_autocmd({ 'DirChangedPre', 'VimLeavePre' }, {
    --       callback = function() Session.store(VIM.loop.cwd()) end,
    --     })
    --   end
    -- })

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
        local function on_attach(bufnr)
          local api = require('nvim-tree.api')

          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          VIM.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
          VIM.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
          VIM.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
          VIM.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
          VIM.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
          VIM.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
          VIM.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
          VIM.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
          VIM.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
          VIM.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
          VIM.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
          VIM.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
          VIM.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
          VIM.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
          VIM.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
          VIM.keymap.set('n', 'a', api.fs.create, opts('Create'))
          VIM.keymap.set('n', '<C-d>', api.fs.remove, opts('Delete'))
          VIM.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
          VIM.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
          VIM.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
          VIM.keymap.set('n', '<C-x>', api.fs.cut, opts('Cut'))
          VIM.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
          VIM.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
          VIM.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
          VIM.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
          VIM.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
          VIM.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
          VIM.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
          VIM.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
          VIM.keymap.set('n', 's', api.node.run.system, opts('Run System'))
          VIM.keymap.set('n', 'q', api.tree.close, opts('Close'))
          VIM.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
          VIM.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
          VIM.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
        end

        require 'nvim-tree'.setup({
          on_attach = on_attach,
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
        })
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
        OPT.foldmethod = "expr"
        OPT.foldexpr = "nvim_treesitter#foldexpr()"
      end,
    }

    -- use({
    --   'mvllow/modes.nvim',
    --   event = 'BufRead',
    --   config = function()
    --     OPT.cursorline = true
    --     require('modes').setup()
    --   end
    -- })

    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
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
          if VIM.bo.filetype == "json" then
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
      'hrsh7th/vim-vsnip',
      requires = {
        'hrsh7th/vim-vsnip-integ',
        'rafamadriz/friendly-snippets',
      }
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
        { 'joshzcold/cmp-jenkinsfile' },
        { 'onsails/lspkind.nvim' },
        { 'hrsh7th/vim-vsnip' },
        { 'hrsh7th/cmp-vsnip' },
      },
      config = function()
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
          mapping    = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          formatting = {
            format = require('lspkind').cmp_format()
          },
          sources    = cmp.config.sources({
            --         { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = 'treesitter' },
            { name = 'buffer' },
            { name = 'path' },
          }),
          snippet    = {
            expand = function(args)
              VIM.fn["vsnip#anonymous"](args.body)
            end,
          },
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

        cmp.setup.filetype("Jenkinsfile", {
          sources = {
            {
              name = "jenkinsfile",
              option = {
                gdsl_file = "~/.config/nvim/private/jenkins.gdsl"
              }
            }
          }
        })

        -- cmp.setup.cmdline({ '/', '?' }, {
        --   mapping = cmp.mapping.preset.cmdline(),
        --   sources = {
        --     { name = 'buffer' }
        --   }
        -- })
      end
    }

    use {
      'williamboman/mason.nvim',
      requires = {
        { 'williamboman/mason-lspconfig.nvim' },
        { 'neovim/nvim-lspconfig' },
        {
          'j-hui/fidget.nvim',
          tag = 'legacy',
        },
        { 'RRethy/vim-illuminate' },
        { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
        { 'onsails/lspkind.nvim' },
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'lukas-reineke/lsp-format.nvim' },
      },
      config = function()
        require('mason').setup()

        require('mason-lspconfig').setup({
          ensure_installed = {
            'ansiblels',
            'bashls',
            'cssls',
            'dockerls',
            'groovyls',
            'lua_ls',
            'helm_ls',
            'ruff_lsp',
            'rust_analyzer',
            'terraformls',
            'tflint',
            'tsserver',
          },
          automatic_installation = true,
        })

        local lsp_format = require("lsp-format")
        lsp_format.setup {}

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lsp_attach = function(client, bufnr)
          -- Create your keybindings here...
          lsp_format.on_attach(client)
        end

        local lspconfig = require('lspconfig')
        local util = require 'lspconfig.util'

        require('mason-lspconfig').setup_handlers({
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = lsp_attach,
              capabilities = lsp_capabilities,
              root_dir = util.find_git_ancestor
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

        VIM.lsp.set_log_level("error")
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
        require('gitsigns').setup({
          sign_priority = 0,
        })

        OPT.signcolumn = "yes"
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
