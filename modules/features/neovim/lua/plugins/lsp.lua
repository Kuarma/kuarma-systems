return {
	{
		"todo-comments.nvim",
		after = function()
			require("todo-comments").setup()
		end,
	},
	{
		"vimtex",
		lazy = false,
		after = function()
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"lazydev.nvim",
		ft = "lua",
		after = function()
			require("lazydev").setup({
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			})
		end,
	},
	{
		"nvim-autopairs",
		event = "InsertEnter",
		after = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
		after = function()
			require("trouble").setup({})
		end,
	},
	{
		"inc-rename.nvim",
		cmd = "IncRename",
		after = function()
			require("inc_rename").setup({})
		end,
	},
	{
		"nvim-lspconfig",
		lazy = false,
		after = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities({
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			})

			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git" },
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			local hostname = vim.fn.hostname()
			local user = vim.env.USER

			vim.lsp.config("nixd", {
				cmd = { "nixd" },
				filetypes = { "nix" },
				root_markers = { "flake.nix" },
				settings = {
					nixd = {
						nixpkgs = {
							expr = "import <nixpkgs> { }",
						},
						options = {
							nixos = {
								expr = "(builtins.getFlake (toString ./.)).nixosConfigurations."
									.. hostname
									.. ".options",
							},
							home_manager = {
								expr = "(builtins.getFlake (toString ./.)).homeConfigurations."
									.. user
									.. "@"
									.. hostname
									.. ".options",
							},
						},
					},
				},
			})

			vim.lsp.enable({ "lua_ls", "nixd" })

			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = false,
				severity_sort = true,
				update_in_insert = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
			})
			vim.keymap.set("n", "<leader>dt", function()
				local state = not vim.diagnostic.config().virtual_text
				vim.diagnostic.config({ virtual_text = state })
			end, { desc = "Toggle virtual text" })

			vim.keymap.set("n", "<leader>dl", function()
				local state = not vim.diagnostic.config().virtual_lines
				vim.diagnostic.config({ virtual_lines = state })
			end, { desc = "Toggle virtual lines" })
		end,
	},
	{
		"conform.nvim",
		event = "BufWritePre",
		after = function()
			require("conform").setup({
				default_format_opts = {
					timeout_ms = 3000,
					async = false,
					quiet = false,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					json = { "oxfmt" },
					json5 = { "oxfmt" },
					yaml = { "yamlfmt" },
					javascript = { "oxfmt" },
					lua = { "stylua" },
					nix = { "nixfmt" },
					tex = { "tex-fmt" },
					plaintex = { "tex-fmt" },
					bib = { "bibtex-tidy" },
					cs = { lsp_format = "fallback" },
					razor = { lsp_format = "fallback" },

					["*"] = { "codespell" },
					["_"] = { "trim_whitespace" },
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},

				format_after_save = {
					lsp_format = "fallback",
				},
			})

			local function cleanup_code()
				vim.system({
					"jb",
					"cleanupcode",
					".",
					"--profile=Built-in: Reformat Code",
				}, { text = true }, function(obj)
					vim.schedule(function()
						if obj.code == 0 then
							vim.cmd("checktime")
							vim.notify("Cleanup complete")
						else
							vim.notify(obj.stderr, vim.log.levels.ERROR)
						end
					end)
				end)
			end

			vim.keymap.set("n", "<leader>cf", cleanup_code, { desc = "JetBrains CleanupCode" })
			vim.keymap.set("n", "<leader>F", function()
				require("conform").format({ async = true })
			end, { desc = "Format current buffer" })
		end,
	},
	{
		"gitsigns.nvim",
		event = "BufReadPre",
		after = function()
			require("gitsigns").setup({})
		end,
	},
}
