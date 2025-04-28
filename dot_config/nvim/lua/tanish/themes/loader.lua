return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		opts = {
			transparent_background = true,
			show_end_of_buffer = true,
		},
	},
	{ "EdenEast/nightfox.nvim" }, -- lazy
	{
		"embark-theme/vim",
		lazy = false,
		priority = 1000,
		config = function()
			-- This function clears the background for several highlight groups
			local function set_transparency()
				vim.cmd("hi Normal guibg=NONE ctermbg=NONE") -- Main background
				vim.cmd("hi NonText guibg=NONE ctermbg=NONE") -- Text area padding
				vim.cmd("hi VertSplit guibg=NONE ctermbg=NONE") -- Vertical split lines
				vim.cmd("hi StatusLine guibg=NONE ctermbg=NONE") -- Status line
				vim.cmd("hi StatusLineNC guibg=NONE ctermbg=NONE") -- Inactive status line
				vim.cmd("hi LineNr guibg=NONE ctermbg=NONE") -- Line numbers
				vim.cmd("hi CursorLine guibg=NONE ctermbg=NONE") -- Cursor line background
				vim.cmd("hi Pmenu guibg=NONE ctermbg=NONE") -- Popup menu
				vim.cmd("hi PmenuSel guibg=NONE ctermbg=NONE") -- Selected popup menu item
				vim.cmd("hi Folded guibg=NONE ctermbg=NONE") -- Folded text
				vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE") -- End of buffer line
				vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE") -- Normal background for non-current windows
			end

			local theme = "embark"
			vim.cmd([[colorscheme ]] .. theme)
			-- set_transparency()
		end,
	},
	{ "AhmedAbdulrahman/vim-aylin" }, -- lazy
	{ "tyrannicaltoucan/vim-deep-space" }, -- lazy
	{ "miikanissi/modus-themes.nvim" }, -- lazy
	{
		"zenbones-theme/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		dependencies = "rktjmp/lush.nvim",
	},
	{ "ribru17/bamboo.nvim" },
	{ "muellan/am-colors" },
	{ "irhl/flowershop.vim" },
	{ "mbeach42/antergos-vm-sp4-rice" },
	{ "projekt0n/caret.nvim" },
	{ "smoka7/celeste-nvim" },
}
