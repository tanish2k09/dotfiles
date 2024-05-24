-- Import some funcs used in keymaps like moving lines up and down
local key_funcs = require("tanish.config.keymap_funcs")

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- Disabled these in favor of Trouble-nvim
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- MacOS keybinds for the meta/alt key:
vim.api.nvim_set_keymap("n", "∆", "<A-j>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "∆", "<A-j>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "∆", "<A-j>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "˚", "<A-k>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "˚", "<A-k>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "˚", "<A-k>", { noremap = true, silent = true })

-- Resize window using <ctrl> arrow keys
vim.api.nvim_set_keymap("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.api.nvim_set_keymap("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.api.nvim_set_keymap("n", "<M-b>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.api.nvim_set_keymap("n", "<M-f>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", key_funcs.move_down_normal, { expr = true, noremap = true, desc = "Move Down" })
vim.keymap.set("n", "<A-k>", key_funcs.move_up_normal, { expr = true, noremap = true, desc = "Move Up" })
vim.keymap.set("i", "<A-j>", key_funcs.move_down_insert, { expr = true, noremap = true, desc = "Move Down" })
vim.keymap.set("i", "<A-k>", key_funcs.move_up_insert, { expr = true, noremap = true, desc = "Move Up" })
vim.keymap.set("v", "<A-j>", key_funcs.move_down_visual, { expr = true, noremap = true, desc = "Move Down" })
vim.keymap.set("v", "<A-k>", key_funcs.move_up_visual, { expr = true, noremap = true, desc = "Move Up" })

-- Keybind shortcut for lazy
vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>Lazy<CR>", { noremap = true, desc = "[L]aunch [L]azy" })

-- Remap add marker keybind 'm' to 'gm' because of vim-easyclip
vim.api.nvim_set_keymap("n", "gm", "m", { noremap = true, silent = false, desc = "Add marker" })

-- Add undo stack break on insert for more precise control over the input text
-- This is different from just using vim motions because we can undo to a DIFFERENT text
vim.api.nvim_set_keymap("i", "<space>", "<space><C-g>u", { noremap = true, silent = true })
