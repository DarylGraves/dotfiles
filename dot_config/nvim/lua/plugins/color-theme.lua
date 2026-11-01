return {
	"fenetikm/falcon",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.falcon_background = 0
		vim.cmd("colorscheme falcon")

		-- Some wnidows still had blue...
		vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
		vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
	end,
}
