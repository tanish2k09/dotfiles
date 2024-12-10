-- Admittedly, noice is a more powerful plugin than I understand.
-- I'll stick with the config from LazyVim for now with some person keymaps

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
			-- ignore the "No information available" notifications on LSP hover trigger
			{
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			},
		},
		presets = {
			bottom_search = true,
			command_palette = false,
			long_message_to_split = true,
			inc_rename = true,
		},
		cmdline = {
			format = {
				-- cmdline = {},
				search_down = { icon = "󰱽/" },
				search_up = { icon = "󰱽?" },
			},
		},
	},
  -- stylua: ignore
  keys = {
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>unl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>unh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>una", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>und", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>unt", function() require("noice").cmd("telescope") end, desc = "Noice Telescope" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
}
