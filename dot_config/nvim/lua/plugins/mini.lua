return { 
	'nvim-mini/mini.nvim', version = '*',
	config = function()
		---- Comments ----
		require('mini.comment').setup({
				mappings = {
						comment = '<C-_>',
						comment_line = '<C-_>',
						comment_visual = '<C-_>',
						textobject = '<C-_>',
				},
		})

		---- Pairs ----
		require('mini.pairs').setup({})

		---- Diff ----
		require('mini.diff').setup({})

		---- Git ----
		require('mini.git').setup({})
	end }
