-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  black  = '#080808',
  white  = '#c6c6c6',
  violet = '#d183e8',
  grey   = '#303030',
  space0       = "#100e23",
  spacebg0      = "#19172B",
  spacebg1	= "#2D2B3E",
  space1       = "#1e1c31",
  space2       = "#2d2b40",
  space3       = "#3e3859",
  space4       = "#585273",
  astral1      = "#cbe3e7",
  cyan         = "#aaffe4",
  darkcyan     = "#63f2f1",
  yellow       = "#ffe9aa",
  darkyellow   = "#ffb378",
  red          = "#f48fb1",
  darkred      = "#ff5458",
  green        = "#a1efd3",
  darkgreen    = "#62d196",
  purple       = "#d4bfff",
  nebula10     = "#78A8ff",
  nebula11     = "#7676ff",
}

local custom_embark = {
	normal = {
		a = { fg = colors.space4, bg = colors.space0, gui = "bold" },
		b = { fg = colors.space4, bg = colors.spacebg0 },
		c = { fg = colors.space4, bg = colors.space1 },
		x = { fg = colors.yellow, bg = colors.space1 },
		y = { fg = colors.space4, bg = colors.spacebg0 },
	},
	visual = {
		a = { fg = colors.nebula10, bg = colors.spacebg0, gui = "bold" },
	},
	command = {
		a = { fg = colors.red, bg = colors.spacebg0, gui = "bold" },
	},
	insert = {
		a = { fg = colors.green, bg = colors.spacebg0, gui = "bold" },
	},
	replace = {
		a = { fg = colors.darkgreen, bg = colors.spacebg0, gui = "bold" },
	},
	inactive = {
		a = { fg = colors.space4, bg = colors.space1, gui = "bold" },
		b = { fg = colors.space4, bg = colors.space1 },
		c = { fg = colors.space4, bg = colors.space2 },
		x = { fg = colors.space4, bg = colors.space1 },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			globalstatus = true,
			always_divide_middle = true,
			theme = custom_embark,
			section_separators = { left = "", right = "" },
			component_separators = " ",
		},
		sections = {
			lualine_a = { { "mode" } },
			lualine_b = {
				{ "filename", icon = "" },
				{ "branch", icon = "󰊢" },
				"diff",
			},
			lualine_c = {},
			lualine_x = {},
			lualine_y = { "lsp_status" },
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
