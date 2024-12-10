return {
	{ "EdenEast/nightfox.nvim" }, -- lazy
	{
		"embark-theme/vim",
		lazy = false,
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme embark]])
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
