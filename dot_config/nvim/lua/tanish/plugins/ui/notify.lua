return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	init = function()
		-- If noice is installed, we let it deal with the notify message options
		if require("lazy.core.config").spec.plugins["noice.nvim"] == nil then
			vim.notify = require("notify")
		end
	end,
	opts = {
		stages = "fade",
		timeout = 3000,
		render = "minimal",
		top_down = false,
		level = vim.log.levels.TRACE,
	},
}
