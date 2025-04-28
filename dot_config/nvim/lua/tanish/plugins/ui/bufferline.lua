return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<leader>b,", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<leader>b.", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<leader>bx", "<cmd>BufferLinePickClose<cr>", desc = "Pick to close buffer" },
		{ "<leader>bg", "<cmd>BufferLinePick<cr>", desc = "Pick to go to buffer" },
		{ "<leader>ba", "<cmd>BufferLineCloseOthers<cr><leader>bd", desc = "Close all buffers" },
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		-- Fix bufferline when restoring a session
		vim.api.nvim_create_autocmd("BufAdd", {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
	opts = {
		options = {
			-- stylua: ignore
			close_command = function(n) require("mini.bufremove").delete(n, false) end,
			-- stylua: ignore
			right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
			diagnostics = "nvim_lsp",
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neo-tree",
					highlight = "Directory",
					text_align = "left",
				},
			},
			separator_style = "thin",
		},
	},
}
