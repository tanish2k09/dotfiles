return {
	"stevearc/dressing.nvim",
	lazy = true,
	init = function()
		local lazy = require("lazy")

		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			lazy.load({ plugins = { "dressing.nvim" } })
			return vim.ui.select(...)
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(...)
			lazy.load({ plugins = { "dressing.nvim" } })
			return vim.ui.input(...)
		end
	end,
	opts = {
		input = {
			insert_only = false,
			start_in_insert = true,
		},
	},
}
