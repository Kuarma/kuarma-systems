return {
	{
		"oil.nvim",
		lazy = false,
		cmd = "Oil",
		keys = {
			{ "-", "<cmd>Oil<cr>", mode = { "n", "v" }, desc = "Go back" },
			{ ".", "<cmd>b#<cr>", mode = { "n", "v" }, desc = "Go back to last opened buffer" },
		},
		after = function()
			require("oil").setup({
				columns = {
					"icon",
				},

				lsp_file_methods = {
					enabled = true,
					timeout_ms = 1000,
					autosave_changes = true,
				},

				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
					["-"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
				},

				default_file_explorer = true,
				skip_confirm_for_simple_edits = true,
				promt_save_on_select_new_entry = false,
				cleanup_delay_ms = 2000,
				use_default_keymaps = true,
				watch_for_changes = true,
				delete_to_trash = true,
				view_options = {
					show_hidden = true,
				},
			})
		end,
	},
	{
		"oil-lsp-diagnostics.nvim",
		after = {
			"oil.nvim",
		},
		config = function()
			require("oil-lsp-diagnostics").setup()
		end,
	},
	{
		"oil-git-status.nvim",
		after = {
			"oil.nvim",
		},
		config = function()
			require("oil-git-status").setup({})
		end,
	},
}
