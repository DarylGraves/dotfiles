return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<C-g>", builtin.live_grep, { desc = "Telescope find strings" })
			vim.keymap.set("n", "<C-s>", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config"), hidden = true })
			end, { desc = "Telescope find nvim config" })

			require("telescope").setup({
				extensions = {
					["fzf"] = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")

			-- Force all Telescope areas to respect your background color
			local groups = {
				"TelescopeNormal",
				"TelescopeBorder",
				"TelescopePromptNormal",
				"TelescopePromptBorder",
				"TelescopePromptPrefix",
				"TelescopeResultsNormal",
				"TelescopeResultsBorder",
				"TelescopePreviewNormal",
				"TelescopePreviewBorder",
			}
			for _, group in ipairs(groups) do
				vim.api.nvim_set_hl(0, group, { bg = "#000000" })
			end
		end,
	},
}
