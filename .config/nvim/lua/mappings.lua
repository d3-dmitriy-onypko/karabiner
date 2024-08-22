require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
nomap("n", "<leader>n")
nomap("n", "<leader>rn")
map("n", "<leader>ce", "<cmd>RustLsp expandMacro<Cr>", { desc = "Expand Macro" })
nomap("n", "<leader>wk") 
nomap("n", "<leader>wK") 
nomap("n", "<leader>v") 
nomap("n", "<leader>h") 
map("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save"})
map("n", "<leader>fl", "<cmd>Telescope resume<cr>", { desc = "Telescope last search" })
map("n", "<leader>cx", "<cmd>RustLsp explainError<Cr>", { desc = "Explain Error" })

map("n", "<tab>", "<cmd>bn<CR>")
map("n", "<S-tab>", "<cmd>bp<CR>")
map("n", "q<tab>", "<cmd>bdelete<CR>")
