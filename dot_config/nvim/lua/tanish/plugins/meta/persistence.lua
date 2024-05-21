return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = { options = vim.opt.sessionoptions:get() },
  -- stylua: ignore
  keys = {
    { "<leader>sr", function() require("persistence").load() end, desc = "[S]ession [R]estore Current" },
    { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "[S]ession Restore [L]ast" },
    { "<leader>sd", function() require("persistence").stop() end, desc = "[S]ession [D]on't Save" },
  },
}
