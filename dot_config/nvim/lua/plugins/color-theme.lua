return {
	"fenetikm/falcon",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.falcon_background = 0
		vim.cmd("colorscheme falcon")
	end,
}
