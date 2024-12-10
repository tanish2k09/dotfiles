return {
	"artemave/workspace-diagnostics.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		local ts_ls = require("lspconfig").ts_ls

		if not ts_ls then
			return
		end

		ts_ls.setup({
			on_attach = function(client, bufnr)
				require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
			end,
		})
	end,
}
