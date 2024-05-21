return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		-- If noice is installed, we let it deal with the notify message options
		if require("lazy.core.config").spec.plugins["noice.nvim"] == nil then
			vim.notify = require("notify")
		end
	end,
	opts = {
		stages = "fade",
		timeout = 2000,
	},
}
