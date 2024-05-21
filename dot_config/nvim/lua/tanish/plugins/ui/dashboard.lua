-- Define your header and add some whitespace
local personalized_header = [[
▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
█░       ░░░░░░░░░░░░░░░░░░░░█
█░           ░░░░░░░░░░░░░░░░░░░░░░█
█░       ░░░░░░░░░░░░░░░░░░░░░░░░░░░░█
█░             ░░░░░░░░░░░░░░░░░░░░░░░░░░░░█
█░         ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█
▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██████████████████████████████                         █
█▄▄░▄▄█░▄▄▀█░▄▄▀██▄██░▄▄█░████    █▀▀▄ █   █  ▀  █▀▄▀█ █
███░███░▀▀░█░██░██░▄█▄▄▀█░▄▄░█ ▄▄ █  █  █▄█   █▀ █ ▀ █ █
███░███▄██▄█▄██▄█▄▄▄█▄▄▄█▄██▄█ ▀▀ ▀  ▀   ▀   ▀▀▀ ▀   ▀ █
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
█░              ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█
█░                 ░░░░░░░░░░░░░░░░░░░░░░░░█
█░               ░░░░░░░░░░░░░░░░░░░░█
█░                 ░░░░░░░░░░░░░░░░█
█░                     ░░░░░░█
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
]]

personalized_header = string.rep("\n", 1) .. personalized_header .. "\n"

return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				header = vim.split(personalized_header, "\n"), --your header
				-- stylua: ignore
				center = {
				{ action = "Telescope find_files",                                 desc = " Find File",       icon = " ", key = "f" },
				{ action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
				{ action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
				{ action = [[lua require('telescope').extensions.live_grep_args.live_grep_args()]], desc = " Grep Text",       icon = "󱙓 ", key = "g" },
				{ action = [[lua require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })]], desc = " Config",          icon = " ", key = "c" },
				{ action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
				{ action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
				{ action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return {
						"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
					}
				end,
			},
		})

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
