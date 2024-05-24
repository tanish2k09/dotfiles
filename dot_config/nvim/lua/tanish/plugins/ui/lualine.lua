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
			theme = {
				normal = {
					a = { fg = colors.black, bg = colors.violet },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white },
				},

				insert = { a = { fg = colors.black, bg = colors.blue } },
				visual = { a = { fg = colors.black, bg = colors.cyan } },
				replace = { a = { fg = colors.black, bg = colors.red } },

				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.white },
				},
			},
			section_separators = { left = "", right = "" },
			component_separators = "",
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
			lualine_b = { "filename", "branch", "diff" },
			lualine_c = { "diagnostics" },
			lualine_x = {},
			lualine_y = { "filetype" },
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
	},
	-- write a custom config function to add trouble status
	config = function(_, opts)
		-- Trouble integration with lualine
		local trouble = require("trouble")
		if not trouble.statusline then
			vim.notify("lualine trouble statusline not found")
			return
		else
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

		require("lualine").setup(opts)
	end,
}
