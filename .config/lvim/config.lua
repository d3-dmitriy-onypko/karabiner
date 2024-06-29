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

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

local codelldb_path = mason_path .. "bin/codelldb"
local liblldb_path = mason_path .. "packages/codelldb/extension/lldb/lib/liblldb.dylib"

vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })

lvim.builtin.which_key.mappings["C"] = {
  name = "Rust",
  r = { "<cmd>RustLsp runnables<Cr>", "Runnables" },
  t = { "<cmd>RustLsp testables<Cr>", "Testables" },
  e = { "<cmd>RustLsp expandMacro<Cr>", "Macro Expand" },
  h = { "<cmd>RustLsp hover actions<Cr>", "Hover" },
  c = { "<cmd>RustLsp flyCheck<Cr>", "Check" },
}

lvim.plugins = {
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    lazy = false,
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
