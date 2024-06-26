-- Provides autosuggestions while typing in cmdline
-- Disabled in favor of Noice's cmdline with tab-complete

return {
	"gelguy/wilder.nvim",
	opts = {
		modes = { ":", "/", "?" },
		next_key = "<Tab>",
		prev_key = "<S-Tab>",
		accept_key = "<C-space>",
		reject_key = "up",
	},
	enabled = false,
}
