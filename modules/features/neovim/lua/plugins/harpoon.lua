return {
	"harpoon2",
	keys = {
		{
			"<C-e>",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Toggle Harpoon menu",
		},
		{
			"<C-a>",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add file to Harpoon",
		},
		{
			"<leader>hp",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Previous Harpoon file",
		},
		{
			"<leader>hn",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Next Harpoon file",
		},
	},
	after = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		for i = 1, 4 do
			vim.keymap.set("n", "<leader>" .. i, function()
				harpoon:list():select(i)
			end, { noremap = true })
		end
	end,
}
