return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = function(_, opts)
		local trouble = require("trouble")
		trouble.statusline({
			  mode = "lsp_document_symbols",
			  groups = {},
			  title = false,
			  filter = { range = true },
			  format = "{kind_icon}{symbol.name:Normal}",
			  hl_group = "lualine_c_normal",
		})
	end
}
