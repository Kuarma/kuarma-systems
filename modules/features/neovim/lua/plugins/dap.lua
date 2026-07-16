return {
	{
		"nvim-dap-virtual-text",
		after = function()
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				all_references = true,
				virt_text_pos = "eol",
				commented = false,
			})
		end,
	},
	{
		"nvim-dap",
		before = function() end,
	},
	{
		"nvim-nio",
		before = function() end,
	},
	{
		"nvim-dap-view",
		version = "1.*",
		before = function() end,
	},
	{
		"nvim-dap-ui",
		keys = {
			{
				"<F1>",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle Debug UI",
			},
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Start/continue debugging",
			},
			{
				"<F2>",
				function()
					require("dap").step_over()
				end,
				desc = "Step over",
			},
			{
				"<F10>",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate session",
			},

			{
				"<C-t>",
				function()
					require("dap.ui.widgets").preview()
				end,
				mode = { "n", "v" },
				desc = "Show variable in preview window",
			},

			{
				"<leader>df",
				function()
					require("dap.ui.widgets").centered_float(
						require("dap.ui.widgets").frames,
						{ border = "rounded", width = 100, height = 20 }
					)
				end,
				desc = "View call stack",
			},

			{
				"<leader>dp",
				function()
					require("dapui").eval()
				end,
				desc = "Evaluate expression under cursor",
			},

			{
				"dP",
				function()
					require("dap.ui.widgets").hover()
				end,
				mode = { "n", "v" },
				desc = "Inspect variable under cursor",
			},

			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Step out",
			},

			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").clear_breakpoints()
				end,
				desc = "Clear breakpoints",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to cursor",
			},

			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle DAP REPL",
			},

			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "Go up stack frame",
			},
			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "Go down stack frame",
			},
		},
		after = function()
			local dap, dapui = require("dap"), require("dapui")

			dapui.setup({
				expand_lines = true,
				force_buffers = true,
				wrap = true,

				controls = {
					element = "breakpoints",
					enabled = true,
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},

				icons = {
					expanded = "▼",
					collapsed = "▶",
					current_frame = "→",
				},

				render = {
					indent = 1,
					max_type_length = 80,
					max_value_lines = 50,
				},

				floating = {
					max_height = 0.9,
					max_width = 0.8,
					border = "rounded",
					mappings = {
						["close"] = { "q", "<Esc>" },
					},
				},

				mappings = {
					expand = { "<CR>", "l" },
					open = { "o" },
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},

				element_mappings = {
					breakpoints = {
						open = "<CR>",
						remove = "dd",
					},
				},

				layouts = {
					{
						elements = {
							{
								id = "console",
								size = 1,
							},
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{
								id = "scopes",
								size = 1,
							},
						},
						size = 40,
						position = "right",
					},
					{
						elements = {
							{ id = "breakpoints", size = 0.5 },
							{ id = "watches", size = 0.5 },
						},
						size = 5,
						position = "bottom",
					},
				},
			})

			vim.api.nvim_set_hl(0, "DapUIScope", {
				fg = "#00ff00",
			})

			vim.api.nvim_set_hl(0, "DapUIVariable", {
				fg = "#999999",
			})

			vim.fn.sign_define("DapStopped", {
				text = "󰳟",
				texthl = "DapStopped",
				numhl = "DapStopped",
			})

			vim.fn.sign_define("DapBreakpoint", {
				text = "🛑",
				texthl = "DapBreakpoint",
				numhl = "DapBreakpoint",
			})

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end

			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
