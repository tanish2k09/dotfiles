-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- TODO: Add a command to set neo-tree root dir to nvim config dir from dashboard

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>fe", ":Neotree toggle<CR>", { silent = true, desc = "[E]xplorer: NeoTree toggle" } },
		{ "<leader>fx", ":Neotree reveal<CR>", { silent = true, desc = "[E]xplorer: NeoTree reveal file" } },
	},
	init = function()
		-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
		-- because `cwd` is not set up properly.
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
			desc = "Start Neo-tree with directory",
			once = true,
			callback = function()
				if package.loaded["neo-tree"] then
					return
				else
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == "directory" then
						require("neo-tree")
					end
				end
			end,
		})
	end,
	opts = {
		event_handlers = {
			{
				event = "neo_tree_popup_input_ready",
				---@param args { bufnr: integer, winid: integer }
				handler = function(args)
					vim.cmd("stopinsert")
					vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
				end,
			},
		},
		git_status = {
			symbols = {
				-- Change type
				added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖", -- this can only be used in the git_status source
				renamed = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = false },
			use_libuv_file_watcher = true,
			hijack_netrw_behaviour = "open_current",
			window = {
				mappings = {
					["\\"] = "close_window",
				},
			},
		},
		-- <CR> does practically the same thing as <space> in the default mappings
		-- But I'm using <space> as leader so I prefer disabling it in neo-tree
		window = {
			mappings = {
				["<space>"] = "",
				["Y"] = {
					function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.setreg("+", path, "c")
					end,
					desc = "Copy Path to Clipboard",
				},
				["O"] = {
					function(state)
						require("lazy.util").open(state.tree:get_node().path, { system = true })
					end,
					desc = "Open with System Application",
				},
			},
		},
		-- Uncomment to use the dressing-nvim inputs instead of the popups
		-- use_popups_for_input = false,
		log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
		log_to_file = false, -- true
	},
}
