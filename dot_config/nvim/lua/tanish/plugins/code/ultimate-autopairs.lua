return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter", "CmdlineEnter" },
	branch = "v0.6", --recommended as each new version will have breaking changes
	opts = {
		--Config goes here
		-- TODO: Fix the closing bracket removal behaviour
	},
	-- disable this for now until further development
	enabled = false,
}
