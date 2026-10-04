return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = function(_, opts)
		return require("indent-rainbowline").make_opts(opts, {
				color_transparency = 0.25,
				colors = {
							0x0c2e0d,
							0x7a4915,
							0x610000,
							0x860000,
						}
				}
		)
	end,
	dependencies = {
		"TheGLander/indent-rainbowline.nvim",
	},
}
