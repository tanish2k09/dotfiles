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
}
