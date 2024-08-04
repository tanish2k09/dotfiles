return {
	"artemave/workspace-diagnostics.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		require("lspconfig").tsserver.setup({
			on_attach = function(client, bufnr)
				require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
			end,
		})
	end,
}
