-- Copilot source
return {
	"zbirenbaum/copilot-cmp",
	dependencies = {
		"zbirenbaum/copilot.lua",
	},
	config = function(_, opts)
		local copilot_cmp = require("copilot_cmp")
		copilot_cmp.setup(opts)

		-- Fixes issues with lazy-loading
		-- We trigger the event to load copilot cmp source
		-- Whenever the LSP attaches
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.name == "copilot" then
					copilot_cmp._on_insert_enter({})
				end
			end,
		})
	end,
}
