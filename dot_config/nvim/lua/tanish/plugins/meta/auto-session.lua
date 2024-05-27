return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			log_level = "error",
			auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
			auto_save_enabled = true,
			auto_restore_enabled = true,
			session_lens = {
				previewer = false,
				theme_conf = {
					winblend = 0,
				},
			},
		})
	end,
}
