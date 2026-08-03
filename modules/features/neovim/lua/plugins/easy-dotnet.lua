return {
	{
		"easy-dotnet.nvim",
		after = function()
			local dotnet = require("easy-dotnet")
			local diagnostics = require("easy-dotnet.actions.diagnostics")

			vim.api.nvim_set_hl(0, "LspCodeLens", {
				fg = "#717171",
				italic = true,
			})

			vim.keymap.set("n", "<leader>Dl", vim.lsp.codelens.run, { desc = "Run CodeLens" })
			vim.keymap.set("n", "<leader>Dd", diagnostics.get_workspace_diagnostics, { desc = "Workspace Diagnostics" })

			dotnet.setup({
				external_terminal = nil,
				background_scanning = true,
				csproj_mappings = true,
				fsproj_mappings = true,

				lsp = {
					enabled = true,
					preload_roslyn = true,
					roslynator_enabled = true,
					easy_dotnet_analyzer_enabled = true,
					auto_refresh_codelens = true,
					restart_roslyn_on_branch_change = true,
					razor = {
						enabled = true,
						html = {
							enabled = true,
							request_timeout = 5000,
						},
					},
				},

				server = {
					log_level = "Off",
					use_visual_studio = false,
				},

				test_runner = {
					enable_buffer_test_execution = true,
					viewmode = "float",
					noBuild = false,
					mappings = {
						run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
						get_build_errors = { lhs = "<leader>e", desc = "get build errors" },
						peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
						debug_test_from_buffer = { lhs = "<leader>d", desc = "run test from buffer" },
						debug_test = { lhs = "<leader>d", desc = "debug test" },
						go_to_file = { lhs = "g", desc = "go to file" },
						run_all = { lhs = "<leader>R", desc = "run all tests" },
						run = { lhs = "<leader>r", desc = "run test" },
						peek_stacktrace = { lhs = "<leader>s", desc = "peek stacktrace of failed test" },
						expand = { lhs = "o", desc = "expand" },
						expand_node = { lhs = "E", desc = "expand node" },
						collapse_all = { lhs = "W", desc = "collapse all" },
						close = { lhs = "q", desc = "close testrunner" },
						refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
						cancel = { lhs = "<C-c>", desc = "cancel in-flight operation" },
					},
				},

				new = {
					project = {
						prefix = "sln",
					},
				},

				projx_lsp = {
					enabled = true,
				},

				debugger = {
					bin_path = vim.fn.exepath("netcoredbg"),
					console = "integratedTerminal",
					apply_value_converters = true,
					auto_register_dap = true,
					mappings = {
						open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
					},
				},

				auto_bootstrap_namespace = {
					type = "file_scoped",
					enabled = true,
					use_clipboard_json = {
						behavior = "auto",
						register = "+",
					},
				},

				diagnostics = {
					default_severity = "error",
					setqflist = true,
				},
			})

			require("easy-dotnet.netcoredbg").register_dap_variables_viewer()
		end,
	},
}
