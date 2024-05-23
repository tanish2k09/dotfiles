return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		start_in_insert = false,
		float_opts = {
			border = "curved",
		},
		auto_scroll = false,
		winbar = {
			enabled = true,
		},
	},
	keys = {
		{ "<C-/>", "<cmd>ToggleTerm direction='float'<CR>", desc = "Toggle floating terminal" },
		{ "<leader>tf", "<cmd>ToggleTerm direction='float'<CR>", desc = "[T]erminal: [F]loating" },
		{ "<leader>tt", "<cmd>ToggleTerm direction='horizontal'<CR>", desc = "[T]erminal: [T]oggle Window" },
	},
}
