return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		vim.g.vimtex_view_method = "sioyek"
		vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
		vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
	end,
}
