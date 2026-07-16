local gs = {
	hidden = true,
	no_ignore = true,
	file_ignore_patterns = {
		".git/",
		"target/",
		"%.lock",
	},
}

return {
	{
		"telescope.nvim",
		version = "*",
		cmd = "Telescope",
		keys = {
			{
				"<space>f",
				function()
					require("telescope.builtin").find_files(gs)
				end,
				desc = "Search files",
			},
			{
				"<space>z",
				function()
					require("telescope.builtin").live_grep(gs)
				end,
				desc = "Live grep",
			},
			{
				"<space>sk",
				function()
					require("telescope.builtin").keymaps(gs)
				end,
				desc = "Keymaps",
			},
			{
				"<space>sg",
				function()
					require("telescope.builtin").git_files(gs)
				end,
				desc = "Git files",
			},
			{
				"<space>sb",
				function()
					require("telescope.builtin").buffers(gs)
				end,
				desc = "Find buffers",
			},
			{
				"<space>sH",
				function()
					require("telescope.builtin").help_tags(gs)
				end,
				desc = "Neovim documentation",
			},
			{ "<space>si", "<cmd>Telescope media_files<cr>", desc = "Media files" },
			{
				"<C-f>",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Effectively Ctrl+f",
			},
		},
		after = function()
			local telescope, actions, action_layout =
				require("telescope"), require("telescope.actions"), require("telescope.actions.layout")

			telescope.load_extension("media_files")
			telescope.load_extension("fzf")

			local fzf_opts = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			}

			telescope.setup({
				pickers = {
					lsp_dynamic_workspace_symbols = {
						sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts),
					},
				},
				extensions = {
					media_files = {
						filetypes = { "png", "webp", "jpg", "jpeg" },
						find_cmd = "rg",
					},
				},
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<c-d>"] = actions.delete_buffer + actions.move_to_top,
							["<M-p>"] = action_layout.toggle_preview,
						},
						n = {
							["<M-p>"] = action_layout.toggle_preview,
							["q"] = actions.close,
						},
					},
				},
			})

			telescope.load_extension("ui-select")
		end,
	},
	{
		"telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-bqf",
		ft = "qf",
	},
	{
		"telescope-media-files.nvim",
		before = function() end,
	},
	{
		"telescope-ui-select.nvim",
		before = function() end,
	},
}
