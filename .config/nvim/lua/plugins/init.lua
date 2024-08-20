return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    },
    keys = {
      {
        "<leader>fj",
        function()
          require("hop").hint_words()
        end,
        mode = {"n", "x", "o"}
      }
    }
  }, 
  {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    opts = {
      inlay_hints = { enabled = true },
    },
  },
  {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup()
    end
  },
  {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
      -- LSP configuration
      server = {
        capabilities = require("nvchad.configs.lspconfig").capabilities,
        on_attach = function(_, bufnr)
          local map = vim.keymap.set
          map("n", "K", "<cmd>lua vim.cmd.RustLsp({ 'hover', 'actions' })<CR>", { buffer = bufnr, desc = "Rust Hover" })
          map(
            "n",
            "<C-Space>",
            "<cmd>lua vim.cmd.RustLsp({ 'completion' })<CR>",
            { buffer = bufnr, desc = "Rust Completion" }
          )
          map(
            "n",
            "<leader>ca",
            "<cmd>lua vim.cmd.RustLsp('codeAction')<CR>",
            { buffer = bufnr, desc = "Rust Code actions" }
          )
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {},
        },
      },
      -- DAP configuration
      dap = {},
    }
  end,
  },
  {
    "saecki/crates.nvim",
    version = "v0.4.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    { -- optional completion source for require statements and module annotations
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "nvim-treesitter/playground" },
      opts = {
        ensure_installed = {
          "vim", "lua", "rust"
        },
        highlight = { enable = true },
        indent = { enable = true }
      }
    },
    {
      "jiaoshijie/undotree",
      dependencies = "nvim-lua/plenary.nvim",
      config = true,
      keys = { -- load the plugin only when using it's keybinding:
        { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
      } 
    }
  }
