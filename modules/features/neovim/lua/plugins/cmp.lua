return {
	{
		"friendly-snippets",
	},
	{
		"blink.cmp",
		version = "1.*",
		after = function()
			local colorful_menu = require("colorful-menu")
			colorful_menu.setup({})

			require("blink.cmp").setup({
				keymap = {
					preset = "default",
					["<Tab>"] = { "select_next", "fallback" },
					["<S-tab>"] = { "select_prev", "fallback" },
					["<C-e>"] = { "select_and_accept", "fallback" },
					["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
					["<A-k>"] = { "show_signature", "hide_signature", "fallback" },
					["<A-s>"] = {
						function(cmp)
							cmp.show({})
						end,
					},
				},

				signature = {
					enabled = true,
					trigger = {
						enabled = true,
						show_on_keyword = true,
						show_on_insert = true,
					},
					window = {
						min_width = 1,
						max_width = 200,
						max_height = 30,
						winblend = 0,
						winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
						direction_priority = { "s" },
						show_documentation = true,
						treesitter_highlighting = true,
					},
				},

				sources = {
					default = {
						"lsp",
						"snippets",
						"path",
					},
				},

				completion = {
					documentation = {
						auto_show = true,
						window = {
							min_width = 15,
							max_width = 200,
							max_height = 50,
							scrollbar = true,
							winblend = 0,
							winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
						},
					},
					ghost_text = { enabled = true },
					list = {
						selection = {
							preselect = false,
							auto_insert = true,
						},
					},
					accept = {
						auto_brackets = { enabled = true },
					},
					menu = {
						enabled = true,
						auto_show = true,
						direction_priority = {
							"s",
							"n",
						},
						min_width = 50,
						max_height = 20,
						winblend = 0,
						scrollbar = false,
						draw = {
							padding = 1,
							snippet_indicator = "~",
							treesitter = { "lsp" },
							components = {
								label = {
									text = function(ctx)
										return colorful_menu.blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return colorful_menu.blink_components_highlight(ctx)
									end,
								},
								icons = {
									text = function(ctx)
										local icon = ctx.kind_icon
										if vim.tbl_contains({ "Path" }, ctx.source_name) then
											local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
											if dev_icon then
												icon = dev_icon
											end
										else
											icon = require("lspkind").symbol_map[ctx.kind] or ""
										end

										return icon .. ctx.icon_gap
									end,
								},
							},
							columns = {
								{ "icons", "kind", gap = 1 },
								{ "label", "label_description", gap = 5 },
							},
						},
					},
				},

				appearance = {
					nerd_font_variant = "normal",
				},

				cmdline = {
					enabled = true,
					completion = {
						menu = { auto_show = true },
						ghost_text = { enabled = true },
					},
					keymap = { preset = "inherit" },
					sources = {
						"buffer",
						"cmdline",
					},
				},

				fuzzy = {
					implementation = "prefer_rust_with_warning",
					max_typos = function(keyword)
						return math.floor(#keyword / 4)
					end,
					frecency = {
						enabled = true,
					},
					use_proximity = true,
					sorts = {
						"score",
						"sort_text",
					},
					prebuilt_binaries = {
						download = true,
					},
				},
			})
		end,
	},
}
