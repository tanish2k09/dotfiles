-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set termguicolors for iTerm 2
vim.opt.termguicolors = true

-- Make line numbers default
vim.opt.number = true

-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Adjust tab size and spacing
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Don't show the tilde fill characters after EOL
vim.opt.fillchars = { eob = " " }

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Disable moving cursor to the first non whitespace char
vim.opt.startofline = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", extends = "⟩", precedes = "⟨", space = "·" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "nosplit"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Define a command to check the status of have_nerd_font
vim.api.nvim_create_user_command("CheckNerdFont", function()
	if vim.g.have_nerd_font then
		print("Nerd Font is available")
	else
		print("Nerd Font is not available")
	end
end, {})
