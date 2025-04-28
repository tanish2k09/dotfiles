-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			globalstatus = true,
			theme = "auto",
			-- {
			-- normal = {
			-- 	a = { fg = colors.black, bg = colors.violet },
			-- 	b = { fg = colors.white, bg = colors.grey },
			-- 	c = { fg = colors.white },
			-- },
			--
			-- insert = { a = { fg = colors.black, bg = colors.blue } },
			-- visual = { a = { fg = colors.black, bg = colors.cyan } },
			-- replace = { a = { fg = colors.black, bg = colors.red } },
			--
			-- inactive = {
			-- 	a = { fg = colors.white, bg = colors.black },
			-- 	b = { fg = colors.white, bg = colors.black },
			-- 	c = { fg = colors.white },
			-- },
			-- },
			section_separators = { left = "", right = "" },
			component_separators = "",
		},
		sections = {
			lualine_a = { { "mode" } },
			lualine_b = { "filename", "branch", "diff" },
			lualine_c = {},
			lualine_x = { "diagnostics" },
			lualine_y = { "copilot" },
			lualine_z = {
				{ "location" },
			},
		},
	},

	-- NOTE: Trouble LSP symbol integration
	config = function(_, opts)
		-- Trouble integration with lualine
		local trouble = require("trouble")
		if trouble.statusline then
			local symbols = trouble.statusline({
				mode = "lsp_document_symbols",
				groups = {},
				title = false,
				filter = { range = true },
				format = "{kind_icon}{symbol.name:Normal}",
			})
			table.insert(opts.sections.lualine_c, {
				symbols.get,
				cond = symbols.has,
			})
		end

		-- Show recording status in lualine
		local noice = require("noice")
		if noice then
			table.insert(opts.sections.lualine_x, {
				noice.api.statusline.mode.get,
				cond = noice.api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			})
		end

		-- Show copiliot status in lualine
		-- This is done in copilot-lualine

		require("lualine").setup(opts)
	end,
}
