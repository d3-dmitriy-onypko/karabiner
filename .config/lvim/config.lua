vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
lvim.log.level = "info"
lvim.format_on_save.enabled = true
lvim.format_on_save = {
  enabled = true,
  pattern = { "*.lua", "*.rs" },
  timeout = 1000,
}

lvim.builtin.treesitter.ensure_installed = {
  "lua",
  "rust",
  "toml",
}

lvim.reload_config_on_save = true
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua", filetypes = { "lua" } },
}

require "lspconfig".nixd.setup{}

vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })

lvim.builtin.which_key.mappings["C"] = {
  name = "Rust",
  r = { "<cmd>RustLsp runnables<Cr>", "Runnables" },
  t = { "<cmd>RustLsp testables<Cr>", "Testables" },
  e = { "<cmd>RustLsp expandMacro<Cr>", "Macro Expand" },
  h = { "<cmd>RustLsp hover actions<Cr>", "Hover" },
  M = { "<cmd>RustLsp rebuildProcMacros<Cr>", "Rebuild Macros" },
  g = { "<cmd>RustLsp codeAction<Cr>", "Code Action" },
  x = { "<cmd>RustLsp explainError<Cr>", "Explain Error" },
  d = { "<cmd>RustLsp renderDiagnostic<Cr>", "Diagnostic" },
  c = { "<cmd>RustLsp flyCheck<Cr>", "Check" },
  y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
  P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
  i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
  f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
  D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
}

lvim.plugins = {
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    lazy = false,
    ft = { "rust" },
    config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = require("lvim.lsp").common_on_attach
      },
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
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  "itchyny/vim-cursorword",
  event = { "BufEnter", "BufNewFile" },
  config = function()
    vim.api.nvim_command("augroup user_plugin_cursorword")
    vim.api.nvim_command("autocmd!")
    vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
    vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
    vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
    vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
    vim.api.nvim_command("augroup END")
  end
}
