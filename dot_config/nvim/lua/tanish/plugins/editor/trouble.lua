return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		{ "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>", desc = "[T]rouble Diagnostics " },
		{ "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[T]rouble buffer Diagnostics" },
		{ "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "[T]rouble [S]ymbols" },
		{
			"<leader>tS",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "[T]rouble LSP references/definitions/...",
		},
		{ "<leader>tL", "<cmd>Trouble loclist toggle<cr>", desc = "[T]rouble [L]ocation List" },
		{ "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", desc = "[T]rouble [Q]uickfix List" },
		{
			"[q",
			function()
				if require("trouble").is_open() then
					require("trouble").prev({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Previous Trouble/Quickfix Item",
		},
	},
}
