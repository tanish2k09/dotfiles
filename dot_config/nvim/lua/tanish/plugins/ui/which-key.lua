return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").register({
			["<leader>b"] = { name = "[B]uffer", _ = "which_key_ignore" },
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>cr"] = { name = "[R]adical", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ebug", _ = "which_key_ignore" },
			["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]oto/[G]it", _ = "which_key_ignore" },
			["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
			["<leader>p"] = "which_key_ignore",
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			["<leader>t"] = { name = "[T]rouble/[T]erminal", _ = "which_key_ignore" },
			["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]ession", _ = "which_key_ignore" },
			["<leader>u"] = { name = "[U]I", _ = "which_key_ignore" },
			["<leader>un"] = { name = "[N]otifications", _ = "which_key_ignore" },
			["<localLeader>l"] = { name = "[V]imtex" },
		})
		-- visual mode
		require("which-key").register({
			["<leader>h"] = { "Git [H]unk" },
		}, { mode = "v" })
	end,
}
