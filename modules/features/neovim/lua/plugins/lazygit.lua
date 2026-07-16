return {
	{
		"lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		keys = {
			{ "<leader>G", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"undotree",
		before = function() end,
	},
}
