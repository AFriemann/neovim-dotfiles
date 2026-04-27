return {
  {
    "saghen/blink.cmp",
    dependencies = {
      { "disrupted/blink-cmp-conventional-commits" },
      { "Kaiser-Yang/blink-cmp-git" },
      {
        "fang2hou/blink-copilot",
        opts = {
          max_completions = 1, -- Global default for max completions
          max_attempts = 2, -- Global default for max attempts
        },
      },
    },
    opts = {
      -- experimental signature support
      signature = {
        enabled = true,
        window = {
          show_documentation = true,
        },
      },
      sources = {
        -- adding any nvim-cmp sources here will enable them with blink.compat
        compat = {},
        default = { "copilot", "lsp", "path", "buffer", "conventional_commits" },
        providers = {
          lsp = {
            async = false,
            fallbacks = {},
          },
          snippets = {
            enabled = false,
            -- friendly_snippets = false,
          },
          conventional_commits = {
            name = "Conventional Commits",
            module = "blink-cmp-conventional-commits",
            enabled = function()
              return vim.bo.filetype == "gitcommit"
            end,
          },
          git = {
            module = "blink-cmp-git",
            name = "Git",
            enabled = function()
              return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
            end,
            opts = {
              -- options for the blink-cmp-git
            },
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            opts = {
              -- Local options override global ones
              max_completions = 3, -- Override global max_completions

              -- Final settings:
              -- * max_completions = 3
              -- * max_attempts = 2
              -- * all other options are default
            },
          },
        },
      },
      completion = {
        keyword = {
          range = "prefix",
        },
        menu = {
          auto_show = true,
        },
        ghost_text = { enabled = true },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      keymap = {
        ["<Tab>"] = {
          "snippet_forward",
          function() -- sidekick next edit suggestion
            return require("sidekick").nes_jump_or_apply()
          end,
          function() -- if you are using Neovim's native inline completions
            return vim.lsp.inline_completion.get()
          end,
          "fallback",
        },
      },
    },
  },
}
