vim.g.radical_no_mappings = true

return {
	"glts/vim-radical",
	dependencies = {
		"glts/vim-magnum",
	},
	event = "BufEnter",
	config = function()
		-- Define our own mappings for radical
		vim.api.nvim_set_keymap(
			"n",
			"<leader>crd",
			"<Plug>RadicalCoerceToDecimal",
			{ noremap = true, silent = true, desc = "[C]ode [R]adical [D]ecimal" }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<leader>crx",
			"<Plug>RadicalCoerceToHex",
			{ noremap = true, silent = true, desc = "[C]ode [R]adical He[X]" }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<leader>cro",
			"<Plug>RadicalCoerceToOctal",
			{ noremap = true, silent = true, desc = "[C]ode [R]adical [O]ctal" }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<leader>crb",
			"<Plug>RadicalCoerceToBinary",
			{ noremap = true, silent = true, desc = "[C]ode [R]adical [B]inary" }
		)
	end,
}
