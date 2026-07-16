return {
	{
		"oil.nvim",
		lazy = false,
		cmd = "Oil",
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
			{ ".", "<cmd>b#<cr>", mode = { "n", "v" }, desc = "Go back to last opened buffer" },
		},
		after = function()
			require("oil").setup({
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
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
		after = function()
			require("oil-lsp-diagnostics").setup()
		end,
	},
	{
		"oil-git.nvim",
		after = function()
			require("oil-git").setup({
				debounce_ms = 50,
				show_file_highlights = true,
				show_directory_highlights = true,
				show_file_symbols = true,
				show_directory_symbols = true,
				show_ignored_files = true,
				show_ignored_directories = true,
				show_branch = true,
				branch_format = " %s",
				symbol_position = "eol",
				can_use_signcolumn = nil,
				ignore_gitsigns_update = false,

				symbols = {
					file = {
						added = "+",
						modified = "~",
						renamed = "->",
						deleted = "D",
						copied = "C",
						conflict = "!",
						untracked = "?",
						ignored = "o",
					},
					directory = {
						added = "*",
						modified = "*",
						renamed = "*",
						deleted = "*",
						copied = "*",
						conflict = "!",
						untracked = "*",
						ignored = "o",
					},
				},

				highlights = {
					OilGitAdded = { fg = "#a6e3a1" },
					OilGitModifiedStaged = { fg = "#f9e2af" },
					OilGitModifiedUnstaged = { fg = "#e5c890" },
					OilGitBranch = { fg = "#89b4fa" },
					OilGitRenamed = { fg = "#cba6f7" },
					OilGitDeleted = { fg = "#f38ba8" },
					OilGitCopied = { fg = "#cba6f7" },
					OilGitConflict = { fg = "#fab387" },
					OilGitUntracked = { fg = "#89b4fa" },
					OilGitIgnored = { fg = "#6c7086" },
				},
			})
		end,
	},
}
