-- project management
return {
	"ahmedkhalf/project.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "[F]ind [P]rojects" },
	},
	config = function()
		require("project_nvim").setup({
			{
				manual_mode = true,
			},
		})
	end,
}
