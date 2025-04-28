local LspUtils = {}

function LspUtils.execute(opts)
	local params = {
		command = opts.command,
		args = opts.args,
	}
	if opts.open then
		require("trouble").open({
			mode = "lsp_command",
			params = params,
		})
	else
		return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
	end
end

LspUtils.codeAction = setmetatable({}, {
	__index = function(_, action)
		return function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { action },
					diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
				},
			})
		end
	end,
})

return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },

		-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
		-- and elegantly composed help section, `:help lsp-vs-treesitter`

		--  This function gets run when an LSP attaches to a particular buffer.
		--    That is to say, every time a new file is opened that is associated with
		--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
		--    function will be executed to configure the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "[L]SP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("<leader>gd", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map("<leader>gs", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map(
					"<leader>gw",
					require("telescope.builtin").lsp_dynamic_workspace_symbols,
					"[G]oto [W]orkspace [S]ymbols"
				)

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("<leader>lr", vim.lsp.buf.rename, "[R]ename")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>la", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap.
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- The following autocommand is used to enable inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- This may be unwanted, since they displace some of your code
				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					map("<leader>lth", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		-- UFO code folding capabilities
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			-- clangd = {},
			-- gopls = {},
			-- pyright = {},
			-- rust_analyzer = {},
			-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
			--
			-- Some languages (like typescript) have entire language plugins that can be useful:
			--    https://github.com/pmizio/typescript-tools.nvim
			--
			-- But for many setups, the LSP (`ts_ls`) will work just fine
			--

			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						diagnostics = { disable = { "missing-fields" }, globals = { "vim" } },
					},
				},
			},
			tailwindcss = {
				settings = {
					tailwindCSS = {
						classAttributes = {
							"class",
							"className",
							"ngClass",
							"class:list",
							".*Style",
							".*Styles",
						},
					},
				},
			},
			ts_ls = {
				enabled = false,
			},
			vtsls = {
				enabled = false,
			},
			-- vtsls = {
			-- 	-- explicitly add default filetypes, so that we can extend
			-- 	-- them in related extras
			-- 	filetypes = {
			-- 		"javascript",
			-- 		"javascriptreact",
			-- 		"javascript.jsx",
			-- 		"typescript",
			-- 		"typescriptreact",
			-- 		"typescript.tsx",
			-- 	},
			-- 	settings = {
			-- 		complete_function_calls = true,
			-- 		ts_ls = {
			-- 			enableMoveToFileCodeAction = true,
			-- 			autoUseWorkspaceTsdk = true,
			-- 			experimental = {
			-- 				maxInlayHintLength = 30,
			-- 				completion = {
			-- 					enableServerSideFuzzyMatch = true,
			-- 				},
			-- 			},
			-- 		},
			-- 		typescript = {
			-- 			updateImportsOnFileMove = { enabled = "always" },
			-- 			suggest = {
			-- 				completeFunctionCalls = true,
			-- 			},
			-- 			inlayHints = {
			-- 				enumMemberValues = { enabled = true },
			-- 				functionLikeReturnTypes = { enabled = true },
			-- 				parameterNames = { enabled = "literals" },
			-- 				parameterTypes = { enabled = true },
			-- 				propertyDeclarationTypes = { enabled = true },
			-- 				variableTypes = { enabled = false },
			-- 			},
			-- 		},
			-- 	},
			-- 	keys = {
			-- 		{
			-- 			"gD",
			-- 			function()
			-- 				local params = vim.lsp.util.make_position_params()
			-- 				LspUtils.execute({
			-- 					command = "typescript.goToSourceDefinition",
			-- 					arguments = { params.textDocument.uri, params.position },
			-- 					open = true,
			-- 				})
			-- 			end,
			-- 			desc = "Goto Source Definition",
			-- 		},
			-- 		{
			-- 			"gR",
			-- 			function()
			-- 				LspUtils.execute({
			-- 					command = "typescript.findAllFileReferences",
			-- 					arguments = { vim.uri_from_bufnr(0) },
			-- 					open = true,
			-- 				})
			-- 			end,
			-- 			desc = "File References",
			-- 		},
			-- 		{
			-- 			"<leader>co",
			-- 			LspUtils.codeAction["source.organizeImports"],
			-- 			desc = "Organize Imports",
			-- 		},
			-- 		{
			-- 			"<leader>cM",
			-- 			LspUtils.codeAction["source.addMissingImports.ts"],
			-- 			desc = "Add missing imports",
			-- 		},
			-- 		{
			-- 			"<leader>cu",
			-- 			LspUtils.codeAction["source.removeUnused.ts"],
			-- 			desc = "Remove unused imports",
			-- 		},
			-- 		{
			-- 			"<leader>cD",
			-- 			LspUtils.codeAction["source.fixAll.ts"],
			-- 			desc = "Fix all diagnostics",
			-- 		},
			-- 		{
			-- 			"<leader>cV",
			-- 			function()
			-- 				LspUtils.execute({ command = "typescript.selectTypeScriptVersion" })
			-- 			end,
			-- 			desc = "Select TS workspace version",
			-- 		},
			-- 	},
			-- },
		}

		-- Mason setup below here
		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
