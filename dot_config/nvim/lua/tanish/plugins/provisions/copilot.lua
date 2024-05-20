return {
	"zbirenbaum/copilot.lua",
	build = ":Copilot auth",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		panel = {
			enabled = false,
		},
		suggestion = {
			enabled = false,
			auto_trigger = false,
		},
	},
}
