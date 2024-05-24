-- nvim v0.8.0
return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	keys = {
		{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazy[G]it: CWD" },
		{ "<leader>gG", "<cmd>LazyGitCurrentFile<cr>", desc = "Lazy[G]it: Current File" },
	},
	config = function()
		vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
	end,
}
